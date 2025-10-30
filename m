Return-Path: <linux-acpi+bounces-18363-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC10C1F941
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 11:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB54C4E2409
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Oct 2025 10:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811133EAEB;
	Thu, 30 Oct 2025 10:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yUezNkgI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1FB30E825
	for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820388; cv=none; b=ebBAsEGpEeZtXT3wQAFaWrLgQOIGlnb14h06FW8A9pNurcs190nI9SGlgnaEX55ZSJQYwU6pLXt1nuQvlxNricR28ciYFAU8hYTf8fSAHiq/Smxrx8FMq3dj2K5ejIAwHdIeTTQaZA6FG7e+9lN76bpr9nDCMSXo4YI8q9IIys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820388; c=relaxed/simple;
	bh=fkQuN4M9OXZln5Gas2xs5QTY9sm7gG9MAV/63TxPaoQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TM5q7O6DwHFxJXm9UbBYEZw1CHwBI7taBx3hZ8BRlUeDahPMK9zJNtGx7EcJIGjxcBarf927foXZqjrU2lH9IcfvzK37sv5PExllGkOtufK3Hp2uG29uzM1POxC2MrtENypWwDLSisT0LsBSCkCifZ0GDRlPi3mMVkMfURjg5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yUezNkgI; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-378e8d10494so8099351fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Oct 2025 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761820385; x=1762425185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWaZZTU8/qNu3sUrivVmXo8XF2FXNMsT2t8CXXY/7N8=;
        b=yUezNkgIYlZTrlfwOJtks2Z8PFebp31FfT6WnJVyTz63o8qDRM4UoMwfx3xYphtYGt
         +3dXpXT3p8YfNPZtkzZG7o7PwD7Awp8tvRF/2NHm4rrGfjy6Pt9oM+fFWt4RSWSZDzX5
         DDlWsD+XHIaG6aG9gB8W9dVqYJdTfraeHjUH3CCM3g/ON9vaeuFY3Zk95AHo+iZOTPu7
         gxmQmEajv5TVBlnLn+23dCw9kHBdB/I96ffgAh0MzJMXZ3qOvsr9Cw49drRaUBM5eo/T
         vTGTlSSdcj628fzo++H5NNWxfYAG/9pgXCj8oBhje1dxO8PWH/MNoUIOssWLpD5G5ukE
         Q1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820385; x=1762425185;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWaZZTU8/qNu3sUrivVmXo8XF2FXNMsT2t8CXXY/7N8=;
        b=GJ3EQc8X6U7xJDo3M7SBnMmztMYQFbVzt/2kSxH08Nn84nQYdc1ZP+7SbB8jJbXq+m
         oMS67Nv1Q32ixtCrWaJR3bFlYxOz7Dw/f26lVGaqbcbjHPBisD03v//YUc9N3CWMHHs+
         B4CytoyPfUTaksgOGtyxL6nyYIPvnlnelQBT5s2g0zxfaFADm0w5nu5tUP9eWkpu14cz
         VshSdJWTK8JqwGwI9oQvpmat85yQiRz7PSLCT3g2W0N2QrLm/qZ8wLd+3vOAL41BWHIM
         nqqPcTWT31J3si9/OX38tuAtZCd6KiyvzAgYIBtLJhUKcBdBPK+MnruphfjfS8lVCSMn
         fDHw==
X-Forwarded-Encrypted: i=1; AJvYcCUj8dg2PgzFVGy0uWTgtY31YktM99mhyAP0NASc4M1feFCc7sVIL/+fuXNkjnuMq4Z/cz48TSP/h8r0@vger.kernel.org
X-Gm-Message-State: AOJu0YwPG46VIIc9mIA0bXbTvMGBSz+TP/e66gmdRyJCReqx7YBdPQZZ
	ov2YH65GMoIWn+vu6xsM9LEOkLb0lozibOdhlTS5aNaB0XoLewyHcX4S6NrS0xws+nXnPrD5tqY
	btgfSORkXNkJFJLE0tOMkyi/lmlcrURsM/IktW7YsaQ==
X-Gm-Gg: ASbGncsLmdRiXsMf08B59I3ZZLPEEiqi6jgd5mIwFkXZ6j4Og8919EwA73eIpSrW06V
	38H1hZtEJqK+NuatT24Cdqc4vKitusyj8dm4BKRwySyxRbV8kFfUbLSKzvfxlvXs5pUNxViWouI
	MG1hmBeo5+jONiiYufxrESgu7SD8gPkx4RnNoxzQCtgnjIxlKJmg1iHlz3dgoORzsJW+hQEGD5f
	bJjLI4MpiL4hKq/jO0e7tg/2U0JeNJIqf1DrtcsxI233/AXc72UxGgDsgc47AiwY6KEMqk0wfjz
	ukPh6aLTx/9GFajRGQ3Ok/2gjg==
X-Google-Smtp-Source: AGHT+IFhFWN/4OudZAxtgLsuvFOZccyNoMyjpf90aD3ueT+mFrZ+QXd3pkXKsskOxyxG+MbzSMsmqJjiGUh6n54vjzA=
X-Received: by 2002:a05:6512:3d0f:b0:592:f115:2949 with SMTP id
 2adb3069b0e04-594128e5f03mr1975919e87.40.1761820384668; Thu, 30 Oct 2025
 03:33:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:33:02 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:33:02 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <aQMxNgC9SWQp-yUy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org> <aQMxNgC9SWQp-yUy@smile.fi.intel.com>
Date: Thu, 30 Oct 2025 03:33:02 -0700
X-Gm-Features: AWmQ_bnzqCfSjLPQSQJvj5qhc2Ow1ivS1ZlAVQqDeOtxRUXYZLAdKO4EXPlIarE
Message-ID: <CAMRc=Md=Dcwj0qDu5ysDafjuV0Ud9z2Ky3PQpDzfiKRt2L-HgQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 10:34:46 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Wed, Oct 29, 2025 at 01:28:36PM +0100, Bartosz Golaszewski wrote:
>>
>> Once we allow software nodes to reference other kinds of firmware nodes,
>> the node in args will no longer necessarily be a software node so bump
>> its reference count using its fwnode interface.
>
> Same, a short comment (or an update of a kernel-doc if present, I don't
> remember).
>

Andy: the resulting code after patch 3/10 looks like this:

struct fwnode_handle *refnode;

(...)

if (ref->swnode)
	refnode = software_node_fwnode(ref->swnode);
else if (ref->fwnode)
	refnode = ref->fwnode;
else
	return -EINVAL;

if (!refnode)
	return -ENOENT;

if (nargs_prop) {
	error = fwnode_property_read_u32(refnode, nargs_prop,
					 &nargs_prop_val);
	if (error)
		return error;

		nargs = nargs_prop_val;
}

(...)

args->fwnode = fwnode_handle_get(refnode);

I'm typically all for comments but this code really is self-commenting.
There's nothing ambiguous about the above. We know the refnode is an fwnode,
we assign it and we pass it to the fwnode_ routines. What exactly would you
add here that would make it clearer?

Bartosz

