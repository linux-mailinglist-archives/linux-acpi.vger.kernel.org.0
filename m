Return-Path: <linux-acpi+bounces-15162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DC7B05983
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 14:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DE03B01DF
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Jul 2025 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BCE2DAFCD;
	Tue, 15 Jul 2025 12:02:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B686418E1F;
	Tue, 15 Jul 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580969; cv=none; b=UZjJ1Kyts2rb2rYbfwAxtH4YyZiIGtg5CrsGQnBz1zimjeeA3VZsEl0Pfnv+7QOJ60oYdlaOlLeF44YP7F6XIC0OBv404hdfy9ootyjgW67uX6lGKYGgpU/HiwGwruNRmkvzI3g4Vl0BOGh0VF4FzwtLhc5sILldwwKML+FlCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580969; c=relaxed/simple;
	bh=Jbdvt3BF3hAniD3y/5avEGNEsscSdz4sfbtK6Ng3HFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhdHuev7+VcnRWCkUwla5j50XyDhV6HJufFknVnKoB6Dd8qVI7IFo+DEfNAARenqJnjqls+WeIi2AsMX2vrcd+UPaGvUhikkKdUf8e35vL+ekHjoawdyEIWv0Va5iYd8K1vfrrjXB2KZMEEddXBgNZwlsntg6f8AqQUvARvjf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8942998a12.3;
        Tue, 15 Jul 2025 05:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580965; x=1753185765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIvf/Fr3LIxkhupGT2xSFgDQIhAUf4dr39mOfS5w4F0=;
        b=FLNyNAuF2fkuU8dKLYHIU2oGvu3eaAQzp9FpHNaOMV8GcVe9UKWgKqsrEtwCE3jr77
         OtkZTTs91cTsTa+56BaFGHoPr2knPZqM/QIV+FBHDiBzyhS2KNiNeH6QXMVE8jHSVQJX
         dzpZ5JjSB6qICbiEXHQq9pwCDqO+I7tLs7a1HOnpKOx4WTPuIjCTG7Y6vB0KNQuPUs15
         WYhLPNygyDs9F+gWROP32IdZmI52ZQbYVn3p6esuBGk6ooTGgBGc6ubS/Wmx+MvHd2BH
         cNVPgP7crHolQw+xVEJA8W779FZ/dLQT+9U07r5+qbAiS5nAlM6aKdkeyrSflRdUAUE6
         f47w==
X-Forwarded-Encrypted: i=1; AJvYcCWl/HhlqblXlEIWKzjlanEYUdZNGypWss6MqBwOcZY9Wv5qOgJNz2FTRYz3rX1nHhNMsxj2MDQEKjybLRfd@vger.kernel.org, AJvYcCXLgMCIjV8cSoIT2G3DaTBiCFu1Oo5/8oSILh8yK2xftgS4M+n9GHWRECPVmQ4gVVaPmkkCxn9gw0TN@vger.kernel.org
X-Gm-Message-State: AOJu0YxbslHOel4b/zKHPlXgK9R/AuWkI2fjDMEgWp5OrYpdSph7/4nc
	Njthvccq8V0d9VxJGIit0xqV8npFiTl+oWOZY6aFY7aeV1pJpQqGhMrp
X-Gm-Gg: ASbGncssd7d6E30iIH3mqyTNlKIf8FM5+BAiZl0kVP/mAjNISPIYOZ5C1VUjoG5hsdR
	dj9LDHzBhgko3lTz1zNIwYfP7F2uwwMT5yFb8XEIwPdWrMvHdA6Ul7GvkaeaKFWQ4XD8/XTRq3d
	5xuBFnWLD5waLi2e3vh8OoICWZaqKmKOA6vzMhX83Rs2qXNm3LuCziI9Su6qIeRWpI5FwyI5jpX
	QiuUFlPBDirYl9HHDV1Q0JAhP8Kd1OYGUzAlABIbLtXKZCbxvBASbjTNQhbIz+y1dXFS+uh+OsT
	SFqW8RE2Vjvw+yWvz26+9gbpjeCH9Nelh2eciQM9cAxWH/CFB64H2VF7npPxIcM9zLc+frVDQo1
	cyjCHuHEeiLmadVlXgkFWvQc=
X-Google-Smtp-Source: AGHT+IGUq0hZMtYifjv/NwhfoQLLm0esSBGSGW2VDcjkCBhU/Fx4Um4vVqrpGWYQ74pVvuWAqovoTQ==
X-Received: by 2002:a05:6402:292:b0:60c:3cca:651a with SMTP id 4fb4d7f45d1cf-611e84f72b5mr12587375a12.33.1752580963098;
        Tue, 15 Jul 2025 05:02:43 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612067f7ca6sm4969050a12.55.2025.07.15.05.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 05:02:41 -0700 (PDT)
Date: Tue, 15 Jul 2025 05:02:39 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>

Hello Borislav,

On Tue, Jul 15, 2025 at 12:31:25PM +0200, Borislav Petkov wrote:
> On Tue, Jul 15, 2025 at 03:20:35AM -0700, Breno Leitao wrote:
> > For instance, If every investigation (as you suggested above) take just
> > a couple of minutes, there simply wouldn’t be enough hours in the day,
> > even working 24x7, to keep up with the volume.
> 
> Well, first of all, it would help considerably if you put the use case in the
> commit message.

Sorry, my bad. I can do better if we decide that this is worth pursuing.

> Then, are you saying that when examining kernel crashes, you don't look at
> I find that hard to believe.

We absolutely do examine kernel messages when investigating crashes, and
over time we've developed an extensive set of regular expressions to
identify relevant errors.

In practice, what you're describing is very similar to the workflow we
already use. For example, here are just a few of the regex patterns we
match in dmesg, grouped by category:

    (r"Machine check: Processor context corrupt", "cpu"),
    (r"Kernel panic - not syncing: Panicing machine check CPU died", "cpu"),
    (r"Machine check: Data load in unrecoverable area of kernel", "memory"),
    (r"Instruction fetch error in kernel", "memory"),
    (r"\[Hardware Error\]: +section_type: memory error", "memory"),
    (r"EDAC skx MC\d: HANDLING MCE MEMORY ERROR", "memory"),
    (r"\[Hardware Error\]:   section_type: general processor error", "cpu"),
    (r"UE memory read error on", "memory"),

And that’s just a partial list. We have 26 regexps for various issues,
and I wouldn’t be surprised if other large operators use a similar
approach.

While this system mostly works, there are real advantages to
consolidating this logic in the kernel itself, as I’m proposing:

    * Reduces the risk of mistakes
    	- Less chance of missing changes or edge cases.

    * Centralizes effort
	- Users don’t have to maintain their own lists; the logic lives
	  closer to the source of truth.

    * Simplifies maintenance
	- Avoids the constant need to update regexps if message strings
	  change.

    * Easier validation
	- It becomes straightforward to cross-check that all relevant
	  messages are being captured.

    * Automatic accounting
	- Any new or updated messages are immediately reflected.

    * Lower postmortem overhead
	- Requires less supporting infrastructure for crash analysis.

    * Netconsole support
	- Makes this status data available via netconsole, which is
	  helpful for those users.


> Because if you do look at dmesg and if you would grep it for hw errors - we do
> log those if desired, AFAIR - you don't need anything new.

Understood. If you don’t see additional value in kernel-side
counting, I can certainly keep relying on our current method. For
us, though, having this functionality built in feels more robust and
sustainable.

Thanks for the discussion,
--breno

