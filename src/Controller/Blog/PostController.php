<?php

namespace App\Controller\Blog;

use App\Repository\Post\PostRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PostController extends AbstractController
{
    #[Route('/', name: 'app.post', methods: 'GET')]
    public function index(PostRepository $postRepository): Response
    {
        $posts = $postRepository->findPublished();
        // findBy(
        //     ['state' => "STATE_PUBLISHED"],
        //     ["createdAt" => "DESC"]
        // );
        //dd($posts);

        return $this->render(
            'pages/blog/index.html.twig',
            ['posts' => $posts]
        );
    }
}