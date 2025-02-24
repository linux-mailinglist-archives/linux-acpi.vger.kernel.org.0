Return-Path: <linux-acpi+bounces-11440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A0A43056
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 23:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A0218936A9
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 22:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4522E20A5FC;
	Mon, 24 Feb 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="eOLqcQT5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD81FCD07;
	Mon, 24 Feb 2025 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437761; cv=none; b=pYCtLIyMhKgodVJK6FZk9qKsDHsgPxGjzCuhfO2OAkJRhndsheYATiwx4qal1ezrSMQSRWGrBXCPxDVG1JRNmsUqtoc6IZbSVLmjiuzZGGNwtsKFiIcc/uL6KQDdb66u3lCmZxKV411MmV/bQktNK2a7ya6ZiZw2NKjic77lzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437761; c=relaxed/simple;
	bh=BVRhx2AEcRGtDjeQiL1fFaOLkSfNxc7OuB9lZUu8L6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXwrnxfDqQDChei3AjaiAY+vzMpVUIFnWVSWSpTpxqnewaTXroktlY84BLpNqlm+tmJbdQUlahRVTp2IvWfWgXA2NbwtN11NZpCGSZERMjau0iQz36VtTiMfGC1hNm2cFPyGceOtLc4KwbkJTJYHtetrcFXu8dUuVi+4fVS3y+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=eOLqcQT5; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3A77B2E0968D;
	Tue, 25 Feb 2025 00:55:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740437756;
	bh=BVRhx2AEcRGtDjeQiL1fFaOLkSfNxc7OuB9lZUu8L6k=;
	h=Received:From:Subject:To;
	b=eOLqcQT5ujt1p57HWil85/XOUWPGjkftC6Fqq/U3T1lUIrzXtx9lcDL/3kO3XcM9A
	 PwverDk/ebx4fuitnzA2x73ARcgeXTEYS/0OiQZLfcVfUGa+x9/DLCA/sXfhQjjn0n
	 O6cwMrDv8+Uo5eJtKXtOOm8aMjYKuM/FDFJPxkrA=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.53) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f53.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-546267ed92fso5754241e87.2;
        Mon, 24 Feb 2025 14:55:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVlIqxtTCSBQcm0qSH2dwVUyQneoqd0a6rOUOH2Iko9O1kz+eodxM21n/vS1hPLSfiQAVa69vo1QcTim5zMVIjqPKHZUQ==@vger.kernel.org,
 AJvYcCWKzDmzlVj6+E/RBBtlo8ZOdV8+wgHjV6oHL4iJlvy3uANpxzSsChQ4ckh81VR7W3LY9A0dpYFHe0qX+c0V@vger.kernel.org,
 AJvYcCX21UeYQp27QfWtIOto+p0EUbt45f6mjnMcIlSREWcezIK6DGGU9u+q5UR6MJsXP6G8rAvY9HflXSOO@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWaU/nRhTSC3i+Gc6BwnTkhvoFXL/Z/HAiNur8HJqL+AMS34P
	AyZjSyTj/q+lt0Ai1hslZ2kxuq/SY2jp6HR5rI2LEnNPQ1udAhwsp5dyjLUNnZnk3t2PgRFxb/1
	HLbGmwovnPa/2WVPVc3eoaeAjvbk=
X-Google-Smtp-Source: 
 AGHT+IGNAVdmzuT5CJ9TkNb8hx56LaUBgxMsKPHThEtCbmDTdC/kGb7oJfr/nUkfyDjRrYkkRm57rNR5kQTV7+HI7Qw=
X-Received: by 2002:a05:6512:1383:b0:545:60b:f384 with SMTP id
 2adb3069b0e04-548510da89cmr260339e87.31.1740437754463; Mon, 24 Feb 2025
 14:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
 <9fa91732-3085-4e79-9a8f-b38263ee7d08@gmx.de>
In-Reply-To: <9fa91732-3085-4e79-9a8f-b38263ee7d08@gmx.de>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 24 Feb 2025 23:55:43 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHZCLaVD8iRgRxvQNqw3v+T9J+omMF+JoNe1r=+S1-OsA@mail.gmail.com>
X-Gm-Features: AWEUYZl39gcPyS8qmcDF3GbriBRZg5CcEiBf4ZklMyc0pbwTkgivbTQsueihJf0
Message-ID: 
 <CAGwozwHZCLaVD8iRgRxvQNqw3v+T9J+omMF+JoNe1r=+S1-OsA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Armin Wolf <W_Armin@gmx.de>
Cc: Luke Jones <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
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
 <174043775574.26560.16251201602174306697@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

> I see. Maybe extending userspace to support the new platform-profile class interface
> could solve this issue without breaking already existing scripts.
>
> However i do not know the amount of work which needs to be done to achieve this.

The patch series I proposed here restores the behavior of the legacy
API 1-1 with 6.13, ensuring that there are no userspace breakages and
allows for maintaining the legacy interface's usefulness in the
future. Without it, once more power profile handlers are added, it
will begin to regress even more. We are also not sure it is just Asus,
it is very likely there will be other breakages.

Currently, platform profile handlers are split in half between
low-power and quiet, and another third has additional options.

The legacy interface is still good for most cases, there is no need to
start moving non-specialized power managers such as ppd to it just
yet.

Antheas

