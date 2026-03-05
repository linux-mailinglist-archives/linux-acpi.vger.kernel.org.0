Return-Path: <linux-acpi+bounces-21414-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL5XLch+qWlB9QAAu9opvQ
	(envelope-from <linux-acpi+bounces-21414-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 14:02:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5922124A7
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 14:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEA633006F09
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD839B968;
	Thu,  5 Mar 2026 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8+bz8Nv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3823947B0
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715580; cv=none; b=EYAxps/rcrrfxXrdWaditKmaBSwwyMozgz8PczTUk5CWqaUP1wsbp1E03yv9r9Em6yDpmtKkCnI6aoW9D06lFxeUCO8ZDSGd4T5jZ8xp7Vam8j6c1+HoO0tz1IjsVJ7jNtikNr4FKhB9veLDwFkI7Jwu5slT83+ex/8pnSrM7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715580; c=relaxed/simple;
	bh=hJmpiIOWInOkV3qbbnLsifIpZUkYd7EmxSaAbHJlkuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctKmKMuUfIU6NUtSTlXvr1IhNnri2Gyiafye1ujGZGvgi1NFQ5d/tfmBVOOucoR38u8NGUDORbnoTHqKGKoqCGuJTdP4hg7CdFHGVHPvpf8oHRzwdpGBwB/fdwzEWybMohT21QQiR8yoVamrvF8YXjKoVocrihhznTqWMDIi9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8+bz8Nv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA76C2BC9E
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772715580;
	bh=hJmpiIOWInOkV3qbbnLsifIpZUkYd7EmxSaAbHJlkuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B8+bz8NvUU3ZjfyhlEYHwnKJnQnWQMNd+c1e/t/cWW9iT470c3B1hA50m1k9B/YEf
	 zSvuVTBN+kbkDGw4azKKK8w23UXa26d6dlZJleNTDqNR0/oJNZDVUAzvg1KE9KhH90
	 E3wvSK4CcqrARs3w+nUNxPLDLSZ3zNs+hE4XvxMFhNs2+CCvIxZAEPjQYP1atC2/OZ
	 /+bs40dp1aejDRILqHN9hKVchfRq9Qz1lntvaTMPg8Jpj49cFD1opBNSs25dGUhIaw
	 rwRW0e2m/RV0TLtC+i1j52fVcY5uvyzZ+zpZXc84nT5wHWn/q++TXt1HRFaVR7W9xm
	 tzVtXopdvd4Pw==
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ca6595c8aso7738148d50.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 04:59:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8msFhzOtfYSH1mOGTMioJVU48LIgjZtfBFsIu29gBcbG6jNwdM4WuhVNezYYtvNDJeL2W99vs0iNs@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwg8rNZnSE5qD+zOxr0iRbKsSavDeecMfrQw7mguzjECWxDIeJ
	MHLEUi4/K1w9qt3Z+bBPp5ZR4UpT7nNT3i0pC7IzJgXTVpWyPHMRb3b8eqPi96IvnCjaNMTUn/X
	Sl82eRa32VK+iRSvrckeHGnPzBxWwd3A=
X-Received: by 2002:a05:690e:d02:b0:649:da44:78ad with SMTP id
 956f58d0204a3-64cf9bab50emr4671980d50.49.1772715579875; Thu, 05 Mar 2026
 04:59:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-gpio-hog-fwnode-v1-0-97d7df6bbd17@oss.qualcomm.com> <20260305-gpio-hog-fwnode-v1-3-97d7df6bbd17@oss.qualcomm.com>
In-Reply-To: <20260305-gpio-hog-fwnode-v1-3-97d7df6bbd17@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Mar 2026 13:59:27 +0100
X-Gmail-Original-Message-ID: <CAD++jL=-Bg3-bO2+j3X6rJraVMPKs7c=ohydNwMfnXC59Bioyw@mail.gmail.com>
X-Gm-Features: AaiRm53UNgtq5CBT6ERTIki7vTWuq6Z_AjQImfj6EE0Rg6alEBc0pTXA_jEAvrI
Message-ID: <CAD++jL=-Bg3-bO2+j3X6rJraVMPKs7c=ohydNwMfnXC59Bioyw@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: sim: use fwnode-based GPIO hogs
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0B5922124A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21414-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,linux.intel.com,iki.fi,atomide.com,armlinux.org.uk,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 10:51=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> Convert gpio-sim to using software nodes for setting up simulated hogs
> instead of legacy machine hogs.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

