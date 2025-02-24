Return-Path: <linux-acpi+bounces-11437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D633A42FA0
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 22:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58D2A18960BA
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D261EC00B;
	Mon, 24 Feb 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="LbB47uL9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196011E0DB3;
	Mon, 24 Feb 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434353; cv=none; b=egMnnLh2LAj0SV2GO98wDYoXNv0XdDY4egCyITCS9aKz+noT5Roue9RjKe7jwMpzf2ob/SbRdDl+/BnX33h2TGbdDa/sXInkVczkR12pVqwbhi6wD5R+9Y6bjBD078eMUFUGKXkdcJar9o46kONSq+D7oZ7yATYp8PKXUetoNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434353; c=relaxed/simple;
	bh=+lLdR93JvyGFMFkJ9+0p7gqHTUM5iD2MlKmP3uHyyUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0ZOe4rX5QHPZt7t0PwUTjCLtjVOjCIQr0/4ttUU8WOufhRnDLK5As0vsbQjO86TnWujr2oExoJFCD7YCqHXpA/v5vBECptSxJK8kNCTqlVuAAr5lXxQLmGZB5vF55gqqJgCQYTxa9IqyyczUA7ugs6fK3InbzrL4tcY5tNtXUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=LbB47uL9; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 255362E090DD;
	Mon, 24 Feb 2025 23:59:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740434348;
	bh=+lLdR93JvyGFMFkJ9+0p7gqHTUM5iD2MlKmP3uHyyUU=;
	h=Received:From:Subject:To;
	b=LbB47uL9cb8O0Pcdr6svb15Oy2IOjp2226YMZHokUl32nfiLnctVaXe2M6ptPxSxk
	 dXfeG66fJAJVYqg28wpTTMkNGI9A4VRKb+qjNWaZaJEeYmzDDIIu3RqtaW+BXXio07
	 ZnTXtkVRFW+o/AjIvS9pfu/BUSP0l439mLqcDhYg=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.50) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f50.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5461a485aa2so4537521e87.2;
        Mon, 24 Feb 2025 13:59:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUSiA/l8FJQt7WtzyHpZF7ykPiNss5KcbYSuUyf6qFKSmla44XEsrBfbxWEuolx6126B2+MwjOcv0oA@vger.kernel.org,
 AJvYcCVsRDDFF6JdHhVIMVNW9vuE80cd5PL83nSpbjgBYG3cQFQXwJ/QBCcIoPJaajYuMiCP8FNp/jZawkpppjdH@vger.kernel.org,
 AJvYcCXreOONdkW4Z5xNboEkNOZdB9enVHA3uZ1Noz7St/q28NG1G8DGb7oue0PRjhkudHq87Nut3e1UYv4jgqWc5/xj//aDpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjXrA6JS1+StQgM96+zBXvPX3/rOJdPS03B/nOIuPAIDVZ9AJ
	H7YNGvsoTLJxzsarFe4RFevtVvOfBkk5ynWgCtH16C7s4lu5fL5kTONcHxfJHrOXX00H3NXF1kn
	y0nk7dfQBozzxNmWIZKN3mKCfqao=
X-Google-Smtp-Source: 
 AGHT+IEOUZZM8wG+y7s+I2W/W5E7BrMT85/AedHLXVXfTDnkTlkHgLzxtLmFDO5wYYqLjru3cBH8EShRKFLIF2Ou8Hk=
X-Received: by 2002:a05:6512:1598:b0:545:5d:a5cd with SMTP id
 2adb3069b0e04-54838ee1eb3mr5271626e87.6.1740434344336; Mon, 24 Feb 2025
 13:59:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
In-Reply-To: <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 24 Feb 2025 22:58:52 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
X-Gm-Features: AWEUYZk7LdmDaBTca-vs5eT2mBsvAD8Od5Rj9fbCvtvgkQJvsP0O-4T0Pa5LLHA
Message-ID: 
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Luke Jones <luke@ljones.dev>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174043434551.1299.8727880088669630990@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

I will tell you that compared with other manufacturers, when asus says
quiet, they mean quiet and not low power

Z13's quiet mode is 40W, not very low-power if you ask me. Ally X uses
13w+boost, a source of many complaints. Other manufacturers use around
8W for low power modes.

In any case, any rename might break user scripts and there are
actually 3 types of low power profiles:
PLATFORM_PROFILE_COOL
PLATFORM_PROFILE_QUIET
PLATFORM_PROFILE_LOW_POWER

Then, there is also:
PLATFORM_PROFILE_BALANCED_PERFORMANCE

Some ACER laptops implement many of those

Obscuring any of those is not ideal.


Antheas

