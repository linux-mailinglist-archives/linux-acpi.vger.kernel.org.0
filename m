Return-Path: <linux-acpi+bounces-5626-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA308BC4AC
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 01:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F91F2165E
	for <lists+linux-acpi@lfdr.de>; Sun,  5 May 2024 23:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0133140367;
	Sun,  5 May 2024 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUwR+esL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F6136E1C;
	Sun,  5 May 2024 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714950216; cv=none; b=eQGpvQp7qCCp0SlUYleszIxQ738EyybFSWSfZLYuO+zSiRG/Rbp6d3SKX/zR9DtrkSQeh2WLUnr7/WWU9nbbEVt89JkrZm/FqCrQp0jBYgrARQ5Zo58ryvvKkBqHiOXbgqIpiEWqx6HSliQ+2f+g2uD05IFonVZjgrdUhD5ydog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714950216; c=relaxed/simple;
	bh=Yi/t1dwyhXI2XCfAAFmWGHdSihInEbM7eoNSA4XmDA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM/sLbMZ40eqzjGdpQJnNGk3skBJumQDakQtZih92Sa92BwYOkBLq7/AMn8dKiXwso5VCLrng6aW1R8F7p9ez4hfrWJI2DXbhStpgL3HZZ+bAP8k0UmYMqeyYIOGyTHhoKt8Jqq8FBZuxAXj0UuDoHdK+7wvz29K5/b8Kr6jFGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUwR+esL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f44d2b3130so1142236b3a.2;
        Sun, 05 May 2024 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714950214; x=1715555014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ixh0Q49+td9KsqPLxjMpp3ISkgfUjGoiYb6DGMNR8c=;
        b=eUwR+esLFvuqU1WQUsAFGbUwVtaR0At3aGAhizhfEVwxtEHtHmj4D1wQDO9Ppo7tT5
         YsOFUDSlWYn1eWay2dDr4wpped3iPJjLTjFuzxgJn0xqG1YhU7jtcetk/L/gY5sR9WHQ
         fqDdlAZ0Z2lLnugwO0E3N/bQYh+dpjdBHF5Cyc0U+Q0axRiJMLDl9FZ8aFi8KJVye47a
         Aeyoyao3h3Lef4U0fpO/Xf844fL6iCaWs5u5mzzRhOmAIwY8OVpuDqP/GxrmdRcaouJt
         OrQo+ReyatCZFp+Q54kmQdcCjo+GGAgiL9lRfOg2EPzi094V2e8lNUW3H0kEPi9DDEWs
         IEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714950214; x=1715555014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ixh0Q49+td9KsqPLxjMpp3ISkgfUjGoiYb6DGMNR8c=;
        b=M/+8eTnLMOPiYHY/CFvSHAv9c9SP6HNIYFG5EpOxyim1vngGyxJuaa8NB5n7KnNp0r
         IowUhZaxjq/xLExgVuKI8qT77knjnTECjSSqGBFjxL+hnvZrgoABpuECSpJX3PfelqyJ
         3FZ+d7pVVQB+RUk42/tRTRGDoeWIKVdXORmwjx5a4pTGNoBTpH69TSSMtU1pGB3AzZx+
         iEYixRWo3EWWBCybz7YySIOBFTluRkdAVDkudME4ul+dluJ0f0NF2LLLYGzHL1cP9wOt
         q3hs56xviyBjLaD2kq3+cDP9INgQ1yOhOx4IzoeB/UQaWiRyL3vGmwAT5MAogxR8g0HW
         tnJA==
X-Forwarded-Encrypted: i=1; AJvYcCUc1v7DhhrV9Ak5kfvj9FXQhTQaz1fwDqzdq10yqDZXv4JNKayWgFAJ7D0bpcQlL+nvp2BzNzBXpAMyebXTuz2HeCzzVIEv8j8PIt9Pq55PAb72qgCAuGn48M4gFLj+/9pPoMP57zgZ/KED45QHMwL04ZyH8+EugNaPp923P/U3bGPuiC9KgMy+ttyZP6PH+nE0pVdhuKZ70j1YZ9yiiUiXiry7maHCJ4b5/Q==
X-Gm-Message-State: AOJu0YzxCMch0Ys/Wcqigi4mZQfNWbJ+mGQ1BZ5DS4qGxLhKIsZC6+84
	L1236xJR39FLa5l1znDNkjPFy6gJKjE1pJFBhlABeWSiCWc7a9tA
X-Google-Smtp-Source: AGHT+IE2mB8S1n9bJnbgreD36wclmulY+xR4ASpHRAO8hPEz1QLWrwuSmmAs2Yn6faTaIr07PlMCyw==
X-Received: by 2002:a05:6a20:3241:b0:1aa:48d1:2144 with SMTP id hm1-20020a056a20324100b001aa48d12144mr6565070pzc.52.1714950214268;
        Sun, 05 May 2024 16:03:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc18-20020a17090325d200b001e85d0b6a7dsm6931807plb.293.2024.05.05.16.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 16:03:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 5 May 2024 16:03:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mlj@danelec.com,
	rafael.j.wysocki@intel.com, lenb@kernel.org, jdelvare@suse.com,
	andy.shevchenko@gmail.com, linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6] ACPI: fan: Add hwmon support
Message-ID: <8c654bca-098f-41c4-8440-880bdbb88b82@roeck-us.net>
References: <20240422195745.5089-1-W_Armin@gmx.de>
 <CAJZ5v0gLQYOWLTmpe24epb9GzV5o2qSuaP5t25eu-OXYoE2pAQ@mail.gmail.com>
 <4c4dbcf8-5c8e-4398-a17d-be5af93f2d6c@roeck-us.net>
 <7f97fa54-8240-4b71-acff-0fc5e92cb710@gmx.de>
 <558ac2ee-2817-4999-97bd-e1bd39681696@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558ac2ee-2817-4999-97bd-e1bd39681696@gmx.de>

On Sun, May 05, 2024 at 07:22:25PM +0200, Armin Wolf wrote:
> 
> Any progress with this?
> 

Not really. It all seems odd, and I returning -ENODATA doesn't seem right,
but then I don't understand the specification or the logic behind it, and
I don't have the time to read and understand it. No objection from my side
against moving forward.

Guenter

