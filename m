Return-Path: <linux-acpi+bounces-18403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B46C2527F
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 14:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB43B4065D3
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Oct 2025 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC5347BA7;
	Fri, 31 Oct 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQR60u0X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033120297C
	for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915831; cv=none; b=iOe/kFfXDtn/nA35V3cPY/BO3Lf0c/b84GKq9qXcO597UOPXQ/BCGnp8umkCOUobGwZJWx5cVFebxfzoCmGKy1vdyqelg0L14/wbfmiIXOTHDwmwPW4HxSL2/1bRzJi7lGus98mo6GbgVRl79RKW5PGEFcVN4ospvVfc6QjoW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915831; c=relaxed/simple;
	bh=PVe6ChdFzqsrPY5cNbPkVd3xBg+1jaFSAtH7ArWrwWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F0qfZxo+pzf7TuHEsVfu+CASTqNnurMOdAYdRKzDfbKOOeQ5jMnaLYOeP/EZrNRnqTVdzl7T21W6YGSmOY0vUjLM25kPIWLZDGY60es5M/lTI9kECG5g5xLIgpIq490PkXA/CdgmlqF/XUXtFscmLNH7lsvggOyeROUvn252ZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iQR60u0X; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47721293fd3so13018815e9.1
        for <linux-acpi@vger.kernel.org>; Fri, 31 Oct 2025 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915828; x=1762520628; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mDV8O3FoSMhSVn/a5ZT560ij4xBeHKhaaWQkgweA8k=;
        b=iQR60u0XklIfO7r3iyZkrG4ta/sGjfTpM5dX3gLOJfAyXb7adaIOh8xF4MLuzI3c4S
         fMJGALstKYNs89lSobplaX0yemRVP0xsLBnKG2qOVwbdZsJQ+cq1gXuGj8gxFKJF8e2G
         tRtGgQ4b1o7gDdEd9RCV2yrmNVaUrFTXL8/1bfsXHPGeArL0oVs4KAB2Ji/vZZxp+v+Z
         5jM5BK3Uv96RpZLJJjBQ6WgNVwlrscy4+C1EO3EV1rlxnj6nnFz/BsXJYpo/tiLkrBp8
         b6gynjmbbhWXbVre49gecy+S6FHD59CjeOb0cASGNSluiOZTyRXKUc64V4NfDrFTsDrz
         QF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915828; x=1762520628;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mDV8O3FoSMhSVn/a5ZT560ij4xBeHKhaaWQkgweA8k=;
        b=Xk12mvRRHwVg58lFVq/GHWLtlVKUoSpKCoDVJTLuT0QQsJRCeria2p9AWXn03kYOv9
         4g40a4LHMZxJ7vIW/cU8+iT/b3c7V7Ch86FJ+4z3sCMJ4rtbabrWNXPl2MquJipPGBG9
         ZaGZFtoKe1fjkLQ6xR2dSd43fZwH/TE5ixQKtkBU1o4narKxhOVLZk9dkaVogmM/rlZz
         7fi1PIOIfoxho7RBzVzwM3b50lR2AQgxnIEYJ8tg999Tw4cNfwC4sBqilVj/fIdhhJSj
         uwyzidG8uhR+STpLgxIIa3LEsFK9kvb6sG0AmyS0FXFIeczJ8CR9UAl61rKA7T0GIWu5
         noCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV0j+XmDlPbU4t4QK+7Gjz35DJgfrvQIyjp7vcSi5JGd3una7zvvEnUtMA42/Wv1YrBUp7OW4MnBA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/DPqI2hB3C6s4Lh21Z3Fnws7GCqiAle2X3wqYn90GwKy2MKkH
	/Mz6vDEQrDy1y/a9dsCeWdpmGq3uh0JKlUGMz7ngbtmJuvXue1QYkxSLxm0HkRPxY0I=
X-Gm-Gg: ASbGncudOxkcjFSiIUi11vwFNJNNRUIDK1UQID4Ot7vHMwbOonKkvghsFxCROXTHsej
	EUERcW4RcMjZwnFsoJf5bGn35ZiIvCCSckENMsv3MNOQkMxVbZmpgBZJjWh/OYcKrbZgpe2WbID
	bmTflLqkpQDwHB9CzMPLbHAYS0h5MfXaFdhrZ3ptN+XOo4pyf3FduTKoBrMYvcMJbosbksdWvbV
	GDsKi/vgk3XY6D+CydElHgUTVrfd3wT7dZkXgI9niRJls8TKl3p3+9MSxCoAsdWr4YhwcwnN5k/
	xWqTy/M7EiCkCwHs0gG2MsCcLLGLFJYIfHimtNVAwSROtba/xVoVYldisEbFllFbD783mibZXah
	MkdZAxWHVTZyxpqZrDijPs+Q2WAFaDQmp59LSPX38YgyRxCwUl2LpFV1Gdh2srhSxHnpZ6wm9KD
	GGM4fFQz2lGMmWT4WK
X-Google-Smtp-Source: AGHT+IG/dcwtB3BjhLCI+K3wmR+DpgBUZwEX6TgzCgzBBCTL3vH0oZwBfJnMRLLw2rYEixnMOXzTGg==
X-Received: by 2002:a05:600c:3495:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-477300980dcmr36025765e9.6.1761915827364;
        Fri, 31 Oct 2025 06:03:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4772fcf38c6sm21694675e9.11.2025.10.31.06.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:03:46 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:03:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexey Starikovskiy <astarikovskiy@suse.de>,
	Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ACPI: SBS: Fix present test in acpi_battery_read()
Message-ID: <aQSzr4NynN2mpEvG@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The battery->present variable is a 1 bit bitfield in a u8.  This means
that the "state & (1 << battery->id)" test will only work when
"battery->id" is zero, otherwise ->present is zero.  Fix this by adding
a !!.

Fixes: db1c291af7ad ("ACPI: SBS: Make SBS reads table-driven.")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is a new static checker warning that Harshit and I wrote.  It's
untested.

 drivers/acpi/sbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index a3f95a3fffde..d3edc3bcbf01 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -487,7 +487,7 @@ static int acpi_battery_read(struct acpi_battery *battery)
 		if (result)
 			return result;
 
-		battery->present = state & (1 << battery->id);
+		battery->present = !!(state & (1 << battery->id));
 		if (!battery->present)
 			return 0;
 
-- 
2.51.0


