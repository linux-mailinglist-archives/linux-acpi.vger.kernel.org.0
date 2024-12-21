Return-Path: <linux-acpi+bounces-10253-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FAF9FA1A4
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 17:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88EE8162F07
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1F148FED;
	Sat, 21 Dec 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5NHSN+d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC6163;
	Sat, 21 Dec 2024 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734799733; cv=none; b=I/cpxyE5W87izKKsEQAo914UqHzBc7Ghr3xsZCOJkN40ZYd9v0NUji0GKT5l+SbHsqIcU98ZWRkoyGxj6Vi0Z2jzyGoa4c3puNTtkjdUzMZ9+4BxHd/x3SbXZgMAcdiHXDDxHjRvUE7o0lt2u1ew5kj8ZqOZCb7inX1lqifUElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734799733; c=relaxed/simple;
	bh=PSYSQdpwXiaZ6u3MWGUf3f+nr11UKU66O2mQaJ9yIz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NK0y0QrzS34MmneNtRListoZ+N8o6WJDWfzN4vth016jB32Nkw6FJ/pcHkMJQdFyAXtUi2bQ1HkLG+QkzwlxNxTJDMqIJ4wynE2YYKhw3mml4hetLdqo3njY2Ue7zv36CIIy0IThHoDLEpWx7Ywa3ukJ5smUsF3nHaubz6tw+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5NHSN+d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436281c8a38so21103705e9.3;
        Sat, 21 Dec 2024 08:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734799730; x=1735404530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00eXxitfkvDkxcdabhP5xUQXiMvqjgvqEwisqJpvhOM=;
        b=h5NHSN+dZTgC1J+uB0XeBj25EQFoQZzmg3HGkxu2EPiMCsbbOa8aMxL817270lscWl
         0jVemVooO+UCnqKZ17xYqhhRYwuUKRc+kO9/sy+JayVFVNPJfM2ssOYjCQ09VWWR7QZx
         OvD89nh7SrMocP026vFbMao2NssOysVRBkOZbNmMGhhai3QUHsgyU5bRXwZbMuDpzuWZ
         XEqkYazruhVShR6CNlbuosJtZl15Y/QuL+6yxHLzK3e1AHPJB406GSnc4HM3K/cIfkem
         PvAzyuIQmD4mWw5NRMjdLHu8wPqn4ptpNKNgngxnxt1BCxUpF5IefW08JWLqZcNGV5mF
         WELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734799730; x=1735404530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00eXxitfkvDkxcdabhP5xUQXiMvqjgvqEwisqJpvhOM=;
        b=nkImIeXns7reLJuVpsbrI2eIyVxLIool9y2UQCVhGn5ETmADDRynHFNBGvTsytBzzj
         ZqVsUSyOEI2LS8iixdTr/Z/GKAPBmoGGOwNLr0Hcr8yv0jAEPlP72hwMoljrI4cwlcjM
         qYLoaCLicmQ+V1ZC+ZL++ogPAB8PfXy9kyWW1t+1Ad0YoB5rV5no8m5vkN3ac1GbCtuu
         Xp/gThcm6gnI6kiTYib72QdIZPsu9hzVJi1E7C4sPSg/BXjoPKw4P2y9UZaxEqaJByEn
         mGWQYPP/AzVjYL9xEKfIcQ0Pp+KwY90JvPE06TsKD9gnh6XKmsO33GwVGUtY1Bv8/87C
         g58A==
X-Forwarded-Encrypted: i=1; AJvYcCVaU0n1jeXDazvCSeX6Bk9tqAbe88Sf91CHB1FYj0acfb4ql80hz/f7GFHZpNAk2myJJho8mRPvBPlf@vger.kernel.org, AJvYcCWOa04v0N8AfABes7tp7Vz6atApl9P9La7JJd89v7BBNn39v6VS5R7Sa0rcym5cR7nXaagy/l3ksK2e6DU=@vger.kernel.org, AJvYcCWQyhtxTSEvpaysjEFzsH1UNFPIeo/9twUT4Pcmurh451p+Ysrmn/tfdtd5uLxG4DyzoqUhOLbIQyM=@vger.kernel.org, AJvYcCWe6EL5WsX/Rv90sZrQXjbql6oIqfvkpghdMUU2CTcaIjXl/aQcZojd8pzUfDKUhuPkzYnFTAkSE50CNtKI@vger.kernel.org, AJvYcCX2G7v6oGdc0FNafLXAuxHcPw25VX+nWVwjzfuvdazn3OIcDBLg1pSrHsBjyeZAcv9cyDB0NKd7IdmqIjJs71eXmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxESzYzuJu8LCQXov8xDVfcvqvfQzruPQCxNOCXF3LYTGQG5rk0
	pWp7pMlew3dv5EqkY16CRoENqB9IEiQDb/715z1onH4ft/SVRuic
X-Gm-Gg: ASbGncsa/kNvCEtNE4Qxo1QUcY4l5cyTdFyKqF8w0k9Sjrzm61kt02B8T8K0fP284Qe
	gN7BFFlN/ux9q84h8lK/mlucWaQnX1I+LHU/fh6Kfp5168pIwoYk/rkDk2bjhcLPouvgScq95ML
	MC2qHqNim6tj0PprWHT2MC2ww7pJAKkLEJUqKByU69B6jbUCbuQpFZGUtSXE+uE5kY8RAtn8QqU
	xtZnAC+Qr8G3xYO/gxBJoao2G1UgNRlVlbf1jtOMydyY6IO2s4vX9KmQ/tFXHhF/Ah+wUrKEXul
	XSUpYbdrabG8FkfCOKUffFs=
X-Google-Smtp-Source: AGHT+IH+Z69jkMyDPzeGlzbES4AhH591gMT/b9P2PBhSN1cZ1okE9sMBjSBCE7gTAveg3SSL4yBNzQ==
X-Received: by 2002:a05:6000:471a:b0:385:c878:62cb with SMTP id ffacd0b85a97d-38a223f7385mr6455978f8f.39.1734799730148;
        Sat, 21 Dec 2024 08:48:50 -0800 (PST)
Received: from dsl-u17-10 (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366120086bsm80969215e9.12.2024.12.21.08.48.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Dec 2024 08:48:49 -0800 (PST)
Date: Sat, 21 Dec 2024 16:48:48 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Andy
 Lutomirski <luto@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Zhang Rui <rui.zhang@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Subject: Re: [RFC PATCH 08/15] x86/cpu/intel: Replace early family 6 checks
 with VFM ones
Message-ID: <20241221164848.7a4f0fcb@dsl-u17-10>
In-Reply-To: <40538b12-5929-4f05-b65e-8b807057abd5@intel.com>
References: <20241220213711.1892696-1-sohil.mehta@intel.com>
	<20241220213711.1892696-9-sohil.mehta@intel.com>
	<20241221103528.2ca530a5@dsl-u17-10>
	<40538b12-5929-4f05-b65e-8b807057abd5@intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 07:57:10 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 12/21/24 02:35, David Laight wrote:
> >>  #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
> >> +#define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
> >> +#define INTEL_PENTIUM_III_TUALATIN	IFM(6, 0x0B)
> >> +#define INTEL_PENTIUM_M_DOTHAN		IFM(6, 0x0D)
> >>  
> >>  #define INTEL_CORE_YONAH		IFM(6, 0x0E)  
> > 
> > I think I'd add all the extra defines in one patch.  
> 
> I actually prefer them being with their first user. That way, if patches
> get dropped or moved, nothing can be in the wrong order or unnecessary.

Does 'unnecessary' matter.
It isn't as though there are hundreds of them.

	David

