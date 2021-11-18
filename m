Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910AB455BA4
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 13:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344748AbhKRMqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 07:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344756AbhKRMpi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Nov 2021 07:45:38 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93970C061764
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 04:42:38 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id m192so1679598qke.2
        for <linux-acpi@vger.kernel.org>; Thu, 18 Nov 2021 04:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=JdAg58blrT6ArecUliYiA4kwOqopT+o2qm7XnvI/ms8=;
        b=WuU+Q3trvqkx5RRdqT6oMSI95p9rWadxx3iNt/nFFTzNNt7qS6ipZfqwnsD5t2v1Gn
         dA0R7k4F3nmCASJIfPNtv+jzn1auK1TBjYDxLRHsvzz0jnuUdAdaBNhkMQ6ZQTQEEdQY
         8omeuLer1la4Bn5z5ZiQvvf4YsO1zSaZJkBD/qOS5Aez4ZCHPyubrMyRFRiWBL4ywn1I
         DzIAVGg5Fh9oDWGsJTWMIZgrRPqwT9fJVCkTMREJNMSHUB81J86bsbWTszGT8hua8xq7
         r1zQZz4wKiBpPlMSOZsbX0lYiNZluhSRXpYbQE/DfQxp/OssXW5oaG9LHu0WuUTFyese
         rpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JdAg58blrT6ArecUliYiA4kwOqopT+o2qm7XnvI/ms8=;
        b=UNvS3C4wN8qpSDPYh46ggiYIhsl6bdIWI73WzyodgNgJerNF+jB7ijnkCnvojgn6OL
         Zd6h4LvwU7lneEcd25O4Uj4zl6FRR6uZ28gvq6qgSIzFGCgkUcB3ynTOa8+jP2f2S6M6
         bk8HYNk8cVDU5tNZ9StzaFWmzvBvDCeejRV28Tt4dmpNVFefhikLT01tZeSyCG7vm+m5
         ygrY9NWiH7iUt5QPnaeq5kD7xoKdOHeWQcGv/Rt7wS6KDwtnzOOOI/QBaGYLPyhyrz55
         xCkGs6Eh6Nox3NMqZRJ4maoF3pUHboPu4thO79Jl2PFB1HzuUAgicSOcpgba4Gi9j3uZ
         wgLA==
X-Gm-Message-State: AOAM531uD0fiU3StgdR1rfpDSl8AKW8XhaxAsuinsevwYa5zjL7P1hUA
        Yav3KuhV1UVlxPCdjPreCRSmF1SsG6ss5MpzT1bj9r51EFdvEA==
X-Google-Smtp-Source: ABdhPJzUxl420axGRUuAUl458XxHok/MCW1Cb33mKEcSPuBPt7apXjtyuMVEcUvJxhYKQDlsav3M2wYtxGElsdDk4QM=
X-Received: by 2002:a05:620a:414a:: with SMTP id k10mr20455470qko.502.1637239357555;
 Thu, 18 Nov 2021 04:42:37 -0800 (PST)
MIME-Version: 1.0
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Thu, 18 Nov 2021 13:42:26 +0100
Message-ID: <CAA85sZtYVGpvTHBwH6LErQqmEvOZFaKtR2xgFWNcbfTXUau2pQ@mail.gmail.com>
Subject: HP Elitebook 840 G5 - acpi failure
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I started updating kernels to 5.14 a while ago and the laptop kept
deadlocking, it's my work laptop so it's quite locked down wrt bios
and bios updates....

But, i have since tried with 5.15.2 and it still crashes...

So the little testing i have is:
acpi=off -> works
acpi=ht -> *boom*

5.13.x did work however and i know there was updates wrt to acpi in 5.14

Older kernel oops can be found here:
https://photos.app.goo.gl/ZygV5Ja39C7cQCR39

I'd basically just want to know what kind of information can I provide
to help you to find and fix this issue?
