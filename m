Return-Path: <linux-acpi+bounces-537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F33D7BE32B
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 16:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DF51C20843
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1731434CC7
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TD1KH/s9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596E0321D
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 12:50:00 +0000 (UTC)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A722199
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 05:49:58 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-45260b91a29so1663988137.2
        for <linux-acpi@vger.kernel.org>; Mon, 09 Oct 2023 05:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696855798; x=1697460598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqVHBhsbROUYrkVKqcZNTMEbfx9Kq7hgDbRTjOfBx4Q=;
        b=TD1KH/s9wbTWECAbs0LvQcLKqYvLAdaDhMYOWGlr5Lzw78IsyGECowME0mMeGM+bxg
         RX5uYnEykgdNzSkhHv8LuOqrUTK+PNkaUHRa4mHrVMQ3i7ocxk5cDFpuY3ZAuEl66fkp
         hD1oMEGnodxdBHdpRn6pht/d9oIPiwbyAYmgXtNWuaGSpjnbfbEolP1hSldyXxd+X8Rs
         lVgiGuLXjOUE5TG/JYc/qrl+5CvsxolVuQ6RE74EMgs1+mW+a+yGjT8r8BW0A9LeQOjn
         J1ar3Fw7+ct/Q9AeOTUqt+RCwVbrggCpvXwjIqyWIwwOZOHUa0d/XGxn4V8jWfqYVW1d
         SzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855798; x=1697460598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqVHBhsbROUYrkVKqcZNTMEbfx9Kq7hgDbRTjOfBx4Q=;
        b=E/sf7k5CO3fziXlhEmt0hQPKqNTvywt2cMfVbtd2CDtn1WTqptUgeADgS3eFA1NDCQ
         J56H14y8WTure/t2RgFgvkFmzfnpFezfKbJ9FoaDK7u/hnQcox8d2ncTTa0UN0+aog8n
         8yk2hbPFWozG/NyYFEgpcRYOJw4/uvAr+KjCZrnIQuYHRDZnJq0eCfR+S6RJJq5yVXKS
         ZAwWusZ+B+YyHsAqX5foreCTZPx9aXqt3v9QDV+vPjWvsuElZquHAEwjDfI4JzF1FGDr
         sZrQPjvVvC+yCIHoxk729NH8lEztj52d51odCQCjymj9ul8lfqLWNXb/1Wl6+cecMY80
         V1qQ==
X-Gm-Message-State: AOJu0YxWEhtNHfgDA2/ajNNxhyxijQHqTabqar+JnXyj2zVv0NNiusSc
	3WGyFY10VCdsAlGDdlQinq7iGPGNJW3GVD6f2i/N5g==
X-Google-Smtp-Source: AGHT+IF8OlnQr0BKaBgObH7+v22TsSrBXBeHAOtNhq4x6SIT97e5mjB7RqcAehoKyOTYt/mv5/OuA3sc2lBTTsdGwGs=
X-Received: by 2002:a67:f585:0:b0:44e:8e28:2853 with SMTP id
 i5-20020a67f585000000b0044e8e282853mr11274007vso.35.1696855797782; Mon, 09
 Oct 2023 05:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <20230926145943.42814-5-brgl@bgdev.pl>
In-Reply-To: <20230926145943.42814-5-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 9 Oct 2023 14:49:47 +0200
Message-ID: <CAMRc=MevHb5pyrcCaGkC7uWChMtzovoP4OA5MZ2Ky7RPT4hn9A@mail.gmail.com>
Subject: Re: [RFT PATCH 4/4] gpio: acpi: remove acpi_get_and_request_gpiod()
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 4:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> With no more users, we can remove acpi_get_and_request_gpiod().
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

With Hans' patches applied, I queued this on top.

Bart

