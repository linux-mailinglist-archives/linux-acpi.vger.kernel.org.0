Return-Path: <linux-acpi+bounces-11435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0FCA42E9D
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 22:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48F3188776D
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 21:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17321A83ED;
	Mon, 24 Feb 2025 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="4F3IGbwj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AFD19924D;
	Mon, 24 Feb 2025 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431309; cv=none; b=msSsmcxTCWZG0o8wZ5O/BAC1br/r3LM5FroSi4vIlv+Yfcoo1Z3e4SlLVkVHMOrvh60ZldUqvl9k1Bm/Wvs1GbdwwL6Vv3clFypzIa8SuNhu3usZoYPsbvFl28H0L/9Sf5L9iBtgEu/rQVbsfYx/lAR/htdfLzTH3GzfMKoZ2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431309; c=relaxed/simple;
	bh=nSvmVEu+bDwLuDudx6Cxjq3+LrMpLO93avt6AWrQfTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeFeSZfOWT9dx1nyB6yBezQPv505BiUMcK1OpEXYwyd2Q3DzQm79Dkh+fRR3VZxFApnBrQZT+THDFhGjy1yCd8ekdXdmOVnQxZdaYnOoq56272ds/plOnCSy95NhlTSDEyDNJvBXn3r81NLKGDdtgQOzV0j4Hiysa5xNPWVgV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=4F3IGbwj; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3E6952E09390;
	Mon, 24 Feb 2025 23:08:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740431303;
	bh=nSvmVEu+bDwLuDudx6Cxjq3+LrMpLO93avt6AWrQfTQ=;
	h=Received:From:Subject:To;
	b=4F3IGbwjkPVCyWeK3Xv+8y4hPQuaWQ87Ne1gkAZGi8xNtaPi/huCi+w9BLuqqsBG8
	 LveVAKx+6H/LwYloBUSOGrJUpK0PHFuA5K+/LOOUkTdWyA+XeeFRHXjrN89CYqDWxe
	 tzbnY8A9m//sgtn+5YjeF+l2JuLJcye6tU4JzsR0=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-307325f2436so47489221fa.0;
        Mon, 24 Feb 2025 13:08:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ6NVPuSkdg7LaQgDqdqztNgOhR8lVKpY7rkrUoB11z8wtWjqd1YnXIUwoghLCrb5nKqVvxrpyLXWpqbO5@vger.kernel.org,
 AJvYcCWRGRVfXYxYGoKcKNtc2fomkckLnbPWzpNWQvO9w5H0tZnmvQy2ZKv3oPL/EL0ADD5ApfVRqJJ0bne66YN4YgQHmzGDhg==@vger.kernel.org,
 AJvYcCXozEDSVOUDcxAmyLdM/XUX6bf4yNAz/l3jC3PSj0uDpswIARzsiIQzt63F7qrxqkms5BoTzQM1o820@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mydXZD00NEiOyk25hJ6b+LqDjwua5VHxHWuGmZJKgwz7+5EJ
	w7seHiU9qCo+uT6M7C1D9vzUZ65sxeWL8ff/v544fzflDKFyLXQfMnYA0PHq9RVFE6FoAtvpORr
	lN1G7vKj+0t8yBoicjSpgAvYeflo=
X-Google-Smtp-Source: 
 AGHT+IGS5wH864ao53flqW1v1Gh3xCaAlLPeoPS3aHIL1uGJGeCUpz69ACzEewmRUqikFS22FDXEW/plBaJ6vCDdjaQ=
X-Received: by 2002:a05:651c:541:b0:308:eb58:6580 with SMTP id
 38308e7fff4ca-30a599b9e2amr63625081fa.33.1740431302369; Mon, 24 Feb 2025
 13:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
In-Reply-To: <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 24 Feb 2025 22:08:11 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwF9rB85zvp4efqVMTu+4B98R7WSzyE_xCh-TfzbMUPBGQ@mail.gmail.com>
X-Gm-Features: AWEUYZl_KzJWCjDBxqyCylnrxhuVzAtguWJ1WiB14Uo4qhOdjC_014pumR1Ni9A
Message-ID: 
 <CAGwozwF9rB85zvp4efqVMTu+4B98R7WSzyE_xCh-TfzbMUPBGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174043130372.6467.11297118136257577281@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Mark,
My primary focus with this patch series is a bug fix. I imported
Mario's series into our Bazzite 6.13 kernel, only to find it broke
power handling on asus laptops, and it will also do the same on both
legion gos, once a driver exists for those.

And 6.14rc4 is the same. This needs to be fixed before it ships.

This was my attempt at it. I considered other options, like making
amd-pmf implement all profiles. But this seems like too dirty for me.
So I settled at this.

The primary TDP handler of a device is the WMI handler. When that
exists, if one of its options is hidden, that is a regression. It does
not matter the option. If we want amd-pmf to be able to load as a
secondary handler (where the point of that has not been proven to me),
then it (or any other secondary handler) cannot obscure the options of
the primary platform. So it either has to implement all of them, or do
something like this, where it is in between.

Antheas

