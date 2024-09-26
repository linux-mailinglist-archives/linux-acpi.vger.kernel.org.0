Return-Path: <linux-acpi+bounces-8433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E11986F78
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DE11C22490
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37622188CB8;
	Thu, 26 Sep 2024 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="OmpCOMg1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B1142E6F;
	Thu, 26 Sep 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341284; cv=none; b=jayrKae2nwQMbEtgedi2y+1g2hBKFa+su9yZZnqaFyrIqqL1VbLS2olOgW4hsJIsxbjPfOdG00DMqYjdOdBr/sDXFQj+kzSaggiaD3LCRrRRU9PzqarINqWKUfvMZfa3Z4+CpbpJj2G21hqQ05jqyut8iiTPwzY4BPo5ADO93ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341284; c=relaxed/simple;
	bh=2/moftCnmmyN+kimiUZ9A+HeNOhYQ5WGqNqSQWmE5jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1DiJBZpluQjZHEU9rnzdt0aNruCk2mQ/P6EdNzt3H8/O1u7SI6m1ZyAj2TvS+udFfXmCjhAm8NeQ1aEV5AIMXdaMMoaivcIFRHdpQPqcSNoly+fOwXkdubAaPPaNblp12KVTjNk4LKmkBmOGadp05jxcdeQ3pvd4aitrJH4LPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=OmpCOMg1; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 7B04F2E086E6;
	Thu, 26 Sep 2024 12:01:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727341277;
	bh=2/moftCnmmyN+kimiUZ9A+HeNOhYQ5WGqNqSQWmE5jo=;
	h=Received:From:Subject:To;
	b=OmpCOMg1e9KM0g69V8Jr9s0Ic9+ODjEsp6xbHH9ZlaZDm5+vYzvfQYsOfYn0xSLxp
	 eudDAoRh/0V2q+GqIbw4XpeHZb/wyPp82/7n6UtbqJDUdIZao7HWoMa7m54q9sUDcs
	 J+5m0TQCI41wWvoBPchuV9geMDuJ5bP1OuyHB414=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f752d9ab62so8026281fa.3;
        Thu, 26 Sep 2024 02:01:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEGoPIlZjKcgKZ58wFEmMMvUMFMMgm6+f3N2vSLusvj6DgQylVYYDHWTwrddP2oKPWiPOBVxj8Ejurwa5iRf1JMk3MSw==@vger.kernel.org, AJvYcCXLDok3ZK6IO4UWkFYl517C1wAbI8bsYVAaCvVjto6Vi/tQSOCIz7wgDfIN6M2Jq1tA2Uotz7mhJmDKwr/M@vger.kernel.org, AJvYcCXYacpPwd3ifkk9kuQvwGS9+jfVEs7EOvfqJaluI5VxVKA0iVWr8lXbqR1wTNaatBQSnyFjymocFFIf@vger.kernel.org
X-Gm-Message-State: AOJu0YybcqUybs0USDCvqtuMedqMUyrF8ER0IWFpyGl3+5BFue5Kq/qY
	G9v8BOUO3GLDZS1uQgJcH9jz6arlpvndWAQJRD3TtfmADH3nwgRMrDkRnmw+mwjHrpWL/72wqT8
	nhocedxC+z+o6yhYISqSJdcXrNI0=
X-Google-Smtp-Source: AGHT+IGVGvBqUNQmUjboLvDDIVzVi/4oCDD8Cd1aWvdGtXC394tYojWWo52z2RknDLo1JPtsVxdf4JWyRgHhk+F5UxQ=
X-Received: by 2002:a05:651c:1547:b0:2f7:52de:9a35 with SMTP id
 38308e7fff4ca-2f91ca64cccmr31295091fa.42.1727341269942; Thu, 26 Sep 2024
 02:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926025955.1728766-1-superm1@kernel.org> <CAGwozwFW-YfVb-CW0uVuZ4wG+Kw9oZaRNkMAZfjvQC98BYxp8Q@mail.gmail.com>
In-Reply-To: <CAGwozwFW-YfVb-CW0uVuZ4wG+Kw9oZaRNkMAZfjvQC98BYxp8Q@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 26 Sep 2024 11:00:58 +0200
X-Gmail-Original-Message-ID: <CAGwozwFQPDvk=XCc=PmtX4L0fCNN1twXGMnc4Xd32cPfyAXrJw@mail.gmail.com>
Message-ID: <CAGwozwFQPDvk=XCc=PmtX4L0fCNN1twXGMnc4Xd32cPfyAXrJw@mail.gmail.com>
Subject: Re: [RFC 0/2] "custom" ACPI platform profile support
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

For testing purposes, the important part would be implementing dummy
attrs for `custom_mode`, and `custom_mode_choices` that both return
`amd-pmf-user` or a name you find more agreeable. Otherwise I cannot
implement an autodiscovery process.

If that change happens, we can begin testing as soon as the middle of next week.

It does not matter if that name is not final, as it can be aliased in
the future.

Antheas

