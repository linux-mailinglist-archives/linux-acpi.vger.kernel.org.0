Return-Path: <linux-acpi+bounces-8078-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDD4968494
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 12:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C3C285AC3
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2024 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1313B5A1;
	Mon,  2 Sep 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="P5iw3VaB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38E13D520
	for <linux-acpi@vger.kernel.org>; Mon,  2 Sep 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725272660; cv=none; b=po6561bbRC2mIMP9gmDA4QXedueL00EqGQzBN97X4GbgaYxD3bix+z5cPkWNnvxAfkTPoh7S9GKJkqt3hyOgSPkzJsxP12Nb1/pH1bzEmIW9QKgOCyKWdRnefqsThBZPNlRFhpOJZyormhSV0tPLi5YoniLxLhQuDqEky0OPr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725272660; c=relaxed/simple;
	bh=gXW5IGW0IPozlyICvSYuGNANAfh1ljoZfqxGc3+VBBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTJrdlhvDePHT0ErZ/HOE29qHQjGCKhBaIo+8nNurnRi5ZwbAy7c0+FRaFstp4ih04cNCDlkqYcfm/aq/46lK1/YWte1WTy2t9qGexxrnGoyZRfRgea5+X4rOCh64FSZzLrJ0T+Huxf6yNn8hh5ro4LTbq0l/hF9zOKtTP4VZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=P5iw3VaB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374cacf18b1so631803f8f.2
        for <linux-acpi@vger.kernel.org>; Mon, 02 Sep 2024 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725272657; x=1725877457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66zc93w6h3Yxyh/dXNjsUBXiL2CdAUkYEm1vEjG0oi0=;
        b=P5iw3VaBvX+c7Y67s6A+3kpW0Fj2tyKZCNddK9vbuj2ANXJsjW5wAWXLwgCf8ZTWso
         ukpf9gaoxS8cukzvE34bLaxwpBenl7ZpUN7j5PUDNBv0vIl8pUTRkMoCz9SqiuQmpqLK
         2d6J27Tljh5zGbDb6uXjT4qEMveCahA0FuyCulJU8O08nRcTIP1HcyGu4RfqjwyGw00e
         T18Z6QUV63DnNU/NutoQbjqKYNkUcfNC/z9a7cvsMBv/qTHHSzCx/a39ljXxZlnFKNnB
         FksJ/z23bjMf7qCOENA1L7EOGTZcete/xmsTxMxQhdJPDhFRB2csEHCGUWqtirVrMtsD
         j4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725272657; x=1725877457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66zc93w6h3Yxyh/dXNjsUBXiL2CdAUkYEm1vEjG0oi0=;
        b=TDkxnTO5o95pGrX7DR5YNR++ZpKESdES7zj/9Z3LMWQJcSNArLA90QXn3GjLMoEl5v
         RDp0EfepMc7AMm6xW1R3DIvmQtaTJ6BHUf02TaNVkCnXMZ9kMvNAYCc4YgwMbGMwp3qd
         E4HpLUuq4QM17MiMUjoWJfx7LCAdnZU0KDRiGIQQ95mEtyUuJd0pFrSqSToejFOb0DAN
         GAYtocMEuQEJeCsHVy/3b1zsQpcU2GD+G7u1svJqHYP1BlRaHqa9Yxh8ip0S8xPzy2ke
         yf7iZqbA2viczOIU+fipKbdxs+BTSIZmiCiq01VNxgoP1XhcHy7GVCwCafcbrO0Py58E
         do+g==
X-Forwarded-Encrypted: i=1; AJvYcCWed8/5ZLvVfupWHQN2hFaxQTUyBgXf+VqFM4D4UXAtOUsUQwSr2xJI+yz1h05kCTYR6PdaZvuQU0HQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0hkbglrcAk6/UqCR7sVUpyM15muPucktrBPjU2Rd5//+40zM
	Qww1ezfUf6I9QbU9Xd/NH7sSWw9aLlqZ+UDewY/vZMjzvU9d9zxTQ/OLXp02l44=
X-Google-Smtp-Source: AGHT+IHjcnbJW7HwD324OLYv7BK1hmnio6Y0jnOfLHKAowm9udV1mN/yQjceZbV45M94QmC8QP2buQ==
X-Received: by 2002:a5d:47a7:0:b0:371:8a69:18b5 with SMTP id ffacd0b85a97d-3749b58962fmr9605503f8f.44.1725272656686;
        Mon, 02 Sep 2024 03:24:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4981asm11069810f8f.24.2024.09.02.03.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 03:24:16 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 1/1] gpiolib: Update the kernel documentation - add Return sections
Date: Mon,  2 Sep 2024 12:24:13 +0200
Message-ID: <172527265102.24810.2842549659164698006.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828164449.2777666-1-andriy.shevchenko@linux.intel.com>
References: <20240828164449.2777666-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 28 Aug 2024 19:41:35 +0300, Andy Shevchenko wrote:
> $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> 67
> 
> Fix these by adding Return sections. While at it, make sure all of
> Return sections use the same style.
> 
> 
> [...]

Applied, thanks!

[1/1] gpiolib: Update the kernel documentation - add Return sections
      commit: b3b12a60eec1415ac68e79e3e6f932772765a897

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

