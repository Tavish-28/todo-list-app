import { useState, useEffect } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Heart, Share2 } from "lucide-react";

const quotes = [
  "The only way to do great work is to love what you do. - Steve Jobs",
  "Believe you can and you're halfway there. - Theodore Roosevelt",
  "Act as if what you do makes a difference. It does. - William James",
  "Success is not final, failure is not fatal: it is the courage to continue that counts. - Winston Churchill",
  "Do what you can, with what you have, where you are. - Theodore Roosevelt"
];

export default function QuoteApp() {
  const [quote, setQuote] = useState("");
  const [favorites, setFavorites] = useState([]);

  useEffect(() => {
    fetchNewQuote();
  }, []);

  const fetchNewQuote = () => {
    const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];
    setQuote(randomQuote);
  };

  const addToFavorites = () => {
    if (!favorites.includes(quote)) {
      setFavorites([...favorites, quote]);
    }
  };

  const shareQuote = () => {
    if (navigator.share) {
      navigator.share({ text: quote });
    } else {
      alert("Sharing is not supported in this browser.");
    }
  };

  return (
    <div className="flex flex-col items-center justify-center min-h-screen bg-gray-100 p-4">
      <Card className="w-full max-w-md text-center p-6 bg-white shadow-lg rounded-2xl">
        <CardContent>
          <p className="text-xl font-semibold mb-4">{quote}</p>
          <div className="flex justify-between mt-4">
            <Button onClick={fetchNewQuote}>New Quote</Button>
            <Button onClick={addToFavorites} variant="ghost">
              <Heart className="text-red-500" />
            </Button>
            <Button onClick={shareQuote} variant="ghost">
              <Share2 className="text-blue-500" />
            </Button>
          </div>
        </CardContent>
      </Card>
      <div className="mt-6 w-full max-w-md">
        <h2 className="text-lg font-bold mb-2">Favorite Quotes</h2>
        <ul className="bg-white shadow rounded-xl p-4">
          {favorites.length > 0 ? (
            favorites.map((fav, index) => <li key={index} className="mb-2">{fav}</li>)
          ) : (
            <p className="text-gray-500">No favorites yet.</p>
          )}
        </ul>
      </div>
    </div>
  );
}
