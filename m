Return-Path: <linux-acpi+bounces-6506-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9015390DDDF
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 22:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF2D1F248A8
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E4E16DC19;
	Tue, 18 Jun 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="nfP/ZnBS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D546BA6
	for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 20:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718744329; cv=none; b=nWjDSfSLJhykmsaRFgqlSXI0+s8rL80IUDaznwlWREfc0HO0jpKW7NBDO8RsWVSBKIZr9GBgvhtUGRKcA71ohWHTfhxABOJpNDVOFzaDoNJEQyB9hJJtTcHAyGaFqRIfJnWHlvB0eR/sQfD6adCiImQLWOdd7bVPbK/nYcGql4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718744329; c=relaxed/simple;
	bh=GL4WG3gGiRy5iVYQEdrg+YE9pgM649jZLwWBiNBLnAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNiFX4FaG1k0pbaqSjCyKlG3mXsiRNmx0kIpxykY7OBGRL0qEipyJgwO12yef9QvrmNbSAmt8VHqtOTzVAb7au1f/8gYpAPn8iaaMOHUuyL9OGJhZOqLBn/iL3j/71nh5fxtdLHzJPj1nktQ2/LM6ZHjjtykf6hMkWFv8cvoy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=nfP/ZnBS; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7eb5dd9f994so231536239f.2
        for <linux-acpi@vger.kernel.org>; Tue, 18 Jun 2024 13:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1718744327; x=1719349127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5fTw4oIChX/XVGvVrvDmot1CuQjy9wAr2Jw7V0wyH4=;
        b=nfP/ZnBSgOuujYLsjEgZkwCqLonrPCRytasRpKRJMFmzx1AHzDuf/zM0tBcsUZt4Q2
         HM4zvMl9KlobFjcf4CfnB1VZvbhzYm00OPpSa+auwO+7KybSi01my25uPLq1DKVOXIe8
         v4wuwSdwNe9Z/ueHYbHFoCFH3L9EtZu9c5PkdlNAeTR/7q6Sh/FT6d1sFmZsNDM+Q32j
         Lg18hOo3Pozmic6wbfw02piX54g6/JRhzMbKpFXpjQjurDOEVOaTgwJxxpRl/LHv70nF
         588FmgtSpxfzi3MQRy2I1w8wzOQ3UDw4r7bR1PIMQE+cNJwcYndoPf+dhTYwJ1wESmV7
         bigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718744327; x=1719349127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5fTw4oIChX/XVGvVrvDmot1CuQjy9wAr2Jw7V0wyH4=;
        b=BLTPQVFxpNSFEFmWXyfl4iaisqMeB5Aqni1BnG+yiwSw5ADwU15Of3QPXzWq5sQJoR
         V0mpCDCme0Us/C9f48+SFN4QCWIsqimndNqeuB6eawYoJaXn9sD3dUM7YDZHtvq7Zttn
         e8u35hkNT84o4FUw0TKmXl8CApUMCTM2ax0617dGP7ho/ISyQXQqtnjEKqbB6KJWDHVX
         gKWxQ7ByrO81/SDfZ0axHQenIIWzMlEQ3nulmcOZ/1Eg69oskm75uuUs+JLVnXAeqoQ+
         +KvPYzKk9wn62B1bqBo9VjAOaTJeTuYVKRAHABwZR3oW0FwhzvkiK+rPKw/nZJ2hCfMc
         IOZw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2LFdpZPStizpzIgt+dkMY6dfpQz/PqAE3LDZBPo26b2mxmjpd1Lp8URLkHPcUXwQWmLsun6rVBhmbguYpwnhWmMAHqd1DyhpnA==
X-Gm-Message-State: AOJu0YwKl0rwzIUw6B3y/aCaBTaQVkG1LqWVhkL4fqZ7OKdNpw9Ad13l
	s5e0lcP29o9U/+3m4bJia2yy0VZO1yrRZmEfEHt8jWTlpAdh0LAplmXBQEC50f0=
X-Google-Smtp-Source: AGHT+IH+yRumAclbJinwAffvWd8nRl0WF/o33t8ouaYeI1M5L7Oo53VGMyQECDT4PGd6eSp9S8KX8Q==
X-Received: by 2002:a05:6602:6415:b0:7eb:6a37:89ce with SMTP id ca18e2360f4ac-7f13ee875b0mr126392339f.14.1718744327667;
        Tue, 18 Jun 2024 13:58:47 -0700 (PDT)
Received: from kf-XE ([2607:fb91:111c:4643:b5f:d6ad:8a73:5578])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b95d3e7fd2sm3113958173.157.2024.06.18.13.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 13:58:47 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:58:44 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: mario.limonciello@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, mmikowski@kfocus.org,
	Perry.Yuan@amd.com
Subject: Re: [PATCH V2 RFC] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
Message-ID: <ZnH1BDVgo--6WEQn@kf-XE>
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
 <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
 <ZnHtPbszYT8afOOk@kf-XE>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnHtPbszYT8afOOk@kf-XE>

On Tue, Jun 18, 2024 at 03:25:36PM -0500, Aaron Rainbolt wrote:
> acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> 
> The _OSC is supposed to contain a bit indicating whether the hardware
> supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> be considered absent. This results in severe single-core performance
> issues with the EEVDF scheduler on heterogenous-core Intel processors.
> 
> To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit",
> which may be used to ignore the _OSC CPPC v2 bit and act as if the bit was
> enabled. This allows CPPC to be properly detected even if not "enabled" by
> _OSC, allowing users with problematic hardware to obtain decent single-core
> performance.
> 
> Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
> 
> ---
> 
> V1 -> V2: Rewrite to work in cpc_supported_by_cpu.
> 
> RFC: I have not yet tested this patch to ensure it functions properly,
>  nor have I attempted to compile it against mainline. My system takes
>  a couple of hours or so to build a kernel, and I'd like to submit this
>  for feedback now and test once it's sent.

I sped up my build by using a defconfig rather than a default menuconfig
(still learning how these things work), and confirmed that the patch does
build against 6.10~rc4. Will report back test results hopefully soon.

