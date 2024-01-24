Return-Path: <linux-acpi+bounces-3036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D3883B2EB
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jan 2024 21:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A1B1F226B5
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jan 2024 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933CD133438;
	Wed, 24 Jan 2024 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ak4Ozkqu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F013133434
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jan 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127371; cv=none; b=mmJOYUhBYxqiDbnwQMYSf5MbrW6h+Vimw3FyYVZxSAWdhjiz+hShVuhAG++PqMDEq9cV7uymhyH8eFTXTIV/ln60eHznfWiV97M9rwxGDdZTWpLwez1ZHUZxeLLY8XhoOWTsd+fd47vNLs8OxTDKdLltdu9cH9Noo1ReyXiP3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127371; c=relaxed/simple;
	bh=AXDCwXx73owg7wj63GSw7ngnDK8Hm+d9fCiD3naBQM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtF3RWO+JYV6j1Sz89FyXYXJLikhW9NQkJxuxokfnVkjcNLPb7IeVQOw62gCpIjy5Qqv/Y2l9E8NSlg0BpoqBbKzR23XWsY5QXHtlXDqqIFaRbsyZ+VtnYzFY0u28Cez3zeYbYjJz4J/qXaGWoc0zo7+OB0xV2ElATvg2hEG3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ak4Ozkqu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce942efda5so4505557a12.2
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jan 2024 12:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706127369; x=1706732169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M9ZXapP4CBzb1A7zLIfbhm/sqmLOdGM3rVISnRAyWrU=;
        b=ak4OzkqudJOZiRpN3nm/SZuMEENLUmjgNOFhpt5rgM2ASt6P0HxiqdOf7Q3puiLZj2
         JD3Hmyr21NO1KbWXRub9TD0xkfOvPibPJts3HtAp0sVsDoQniqzRp5QT/5uMIwCV5gt4
         jDNhY1emRTtWGv+h40IibHV5FOdcXh9t1R1u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706127369; x=1706732169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9ZXapP4CBzb1A7zLIfbhm/sqmLOdGM3rVISnRAyWrU=;
        b=dVxIKnMcod9Gm683pOezl9EwwjQNYA4TFRSRQ4Q9OpGPw1cYbBJh3mpvExlGsT44uR
         YIUDUEtiRhUp4K4NM6Jg+j2Y0HlVIMUfXzG9pXo0nHsJAcQqFvcMjRyHH5hb9apcW2pJ
         4CMO+F+yeAGWslB763/qy6wsVZcql6bYnZhmY8ggvFeNCm47MUjYUrqPETxAjkmKn4ka
         L9H+cBWAN3M/oWON0ZnPOUNGEI9/HRno/IxBDm4tiUggRGD0DS5TASZJg/4Pu9s4W17u
         XrzRA5yn3b1PSeWLFzlR4MD3Q33iNH9e0MQ3rAQziEEQ0cY3F3sxFfG2haII8R7lpDsE
         MDTw==
X-Gm-Message-State: AOJu0YzdiBI+W5I8P3MoNDj2XxMe1zXNAuOKfAIP3AKxZM7knCEz0kQ4
	RxWIIJzzbC0UBBHUKe6oRQ00fP3kukK4I0za4N4Np+PlYoVYsb0Xl4OTgRLHGg==
X-Google-Smtp-Source: AGHT+IGHchkhtFJWS8YRr7A4F/OJ0bBqhApewB8XUKYtacaZB9fZnHw7eK4j5Pe/5pPgkaOZuifTkA==
X-Received: by 2002:a17:90a:9417:b0:28d:6230:c1a2 with SMTP id r23-20020a17090a941700b0028d6230c1a2mr87254pjo.50.1706127369470;
        Wed, 24 Jan 2024 12:16:09 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090aa79200b00290ffbe5ca3sm44874pjq.55.2024.01.24.12.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:16:08 -0800 (PST)
Date: Wed, 24 Jan 2024 12:16:08 -0800
From: Kees Cook <keescook@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-hardening@vger.kernel.org, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/82] ACPI: custom_method: Refactor intentional
 wrap-around test
Message-ID: <202401241215.32C7B45EF@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-35-keescook@chromium.org>
 <CAJZ5v0gLr69vzLr_+yhP4z96nzFZjDfaPR-sTdkiv08vHbBe7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gLr69vzLr_+yhP4z96nzFZjDfaPR-sTdkiv08vHbBe7w@mail.gmail.com>

On Wed, Jan 24, 2024 at 08:52:48PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 23, 2024 at 2:03 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > In an effort to separate intentional arithmetic wrap-around from
> > unexpected wrap-around, we need to refactor places that depend on this
> > kind of math. One of the most common code patterns of this is:
> >
> >         VAR + value < VAR
> >
> > Notably, this is considered "undefined behavior" for signed and pointer
> > types, which the kernel works around by using the -fno-strict-overflow
> > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > want to get the kernel source to the position where we can meaningfully
> > instrument arithmetic wrap-around conditions and catch them when they
> > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > or pointer[4] types.
> >
> > Refactor open-coded wrap-around addition test to use add_would_overflow().
> > This paves the way to enabling the wrap-around sanitizers in the future.
> >
> > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > Link: https://github.com/KSPP/linux/issues/26 [2]
> > Link: https://github.com/KSPP/linux/issues/27 [3]
> > Link: https://github.com/KSPP/linux/issues/344 [4]
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: linux-acpi@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/acpi/custom_method.c | 2 +-
> 
> I may attempt to drop custom_method.c in this cycle, is there a
> problem if I take this into my tree for now?

The helper doesn't exist in tree yet, but it may be a bit before these
refactors land, so if custom_method vanishes before then, that's great!
:)

-Kees

-- 
Kees Cook

