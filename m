Return-Path: <linux-acpi+bounces-20704-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMSzBK/QeWlCzwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20704-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 10:02:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234E9E94E
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 10:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15E553035C62
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 09:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD0A33C1BF;
	Wed, 28 Jan 2026 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC/2kWwb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779633C1B9
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590933; cv=none; b=A+bYKeU9qt+IGpv9hSc3Iy1SN+AN0oXtrRMtZGLErOJxO7NsGrpmkI/bv6A7ZLpEpbfY29+LcvO4AFr0cWfM8oHTwasSsN8b0rdCY1ZQIRG0hnxTr3nFmaj/UaEWY90P6seAjDbwSOFvjGBAdJQHQAy/0r1inIGjGrJgEMkUlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590933; c=relaxed/simple;
	bh=V/XRA3cCQHCy7Knmk6QpfTE1N8y2yvLc3ufqv8601R4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keSDCRvh32/gwBFHijnD9IgQZ5Em63ANIudjEvCACreY3jdc93SOkgrWDNV399wLqdWbZFwLf6eqO83277NZRzTWNN80sSOHSv3utNKMIaaggPZpt4gKaGN6BXeEFXppRHmRAwLH1kUp+/8n2kuxZ9b/G2lgKe9w2WNGg78SKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC/2kWwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF32C4AF09
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769590933;
	bh=V/XRA3cCQHCy7Knmk6QpfTE1N8y2yvLc3ufqv8601R4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=eC/2kWwb4OFHR0vdsEcYYYPI/8/c8yLVU8TQHzZSM3mtm/UPSjxQ/qxJL1wM9SsZ2
	 /r4wn82hU1i3KY6W25u2vGvnU+CXy3HZmc3oxLqPNTOBpfhIQWx/VCm2KTGZWU2Whs
	 D/E/IhaHL7UvSz7z6R9I5qYTybrLkgsX9xbcnUcOxb4hXDY1QcUPSp08S+SrByH3gS
	 +RW6+DN68/Qb0sYg2dsQSf9aOfDmNF5ee9+07SRjlnIPt7k4AlvhjPJrXUaRZxnXXp
	 U+knyi33Zn/YXUTjc1NaRYdNYij4Z0MXS51++AVNjWLMAmdL5MEJdxAyTT9hVTL6Gc
	 pEpb9TBxX7Nug==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b9fee282dso6135126e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 01:02:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRo2BdLecB+okjhD0iwJZORvu7Cazi6p1a2yVX/RGnqz7un7AoqbJVIh7qMy/P0qtQ/8V5EsagAoXb@vger.kernel.org
X-Gm-Message-State: AOJu0YziYnTA1DdhHV56HQRV9kPTpDxpzxtMMNsptQrpW+7LMzu8sD6S
	gWtHsUeSwRFGeFkXbo6XW2g4MTGKet4kaR5514iwl0YRA+6N5pYNJpxvmyb9BbUhjTDs/BqalYo
	4+ILhx2rdAz7iyC6aHJutJ3wvgr7nem0NIbtGLZgMdA==
X-Received: by 2002:a05:6512:1286:b0:59d:e7ac:619f with SMTP id
 2adb3069b0e04-59e04021341mr1851252e87.18.1769590932195; Wed, 28 Jan 2026
 01:02:12 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 01:02:11 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Jan 2026 01:02:11 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aXjCfwnnASFZ1Ghh@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127110824.4020130-1-andriy.shevchenko@linux.intel.com>
 <20260127134300.GK2275908@black.igk.intel.com> <aXjCfwnnASFZ1Ghh@smile.fi.intel.com>
Date: Wed, 28 Jan 2026 01:02:11 -0800
X-Gmail-Original-Message-ID: <CAMRc=Me=TFk6XZtLJ9XGBdYtQRb=-tLqXy+x7mteBe8ANvqEKA@mail.gmail.com>
X-Gm-Features: AZwV_Qi_vkEsHIQbET7UCHTmJv8XDGLmgvfxjRYnppwE2x-IKPKlg9YtNeecnjk
Message-ID: <CAMRc=Me=TFk6XZtLJ9XGBdYtQRb=-tLqXy+x7mteBe8ANvqEKA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpiolib: acpi: Fix potential out-of-boundary left shift
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	TAGGED_FROM(0.00)[bounces-20704-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-acpi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3234E9E94E
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 14:49:51 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Tue, Jan 27, 2026 at 02:43:00PM +0100, Mika Westerberg wrote:
>> On Tue, Jan 27, 2026 at 12:06:30PM +0100, Andy Shevchenko wrote:
>> > GPIO Address Space handler gets a pointer to the in or out value.
>> > This value is supposed to be at least 64-bit, but it's not limited
>> > to be exactly 64-bit. When ACPI tables are being parsed, for
>> > the bigger Connection():s ACPICA creates a Buffer instead of regular
>> > Integer object. The Buffer exists as long as Namespace holds
>> > the certain Connection(). Hence we can access the necessary bits
>> > without worrying. On the other hand, the left shift, used in
>> > the code, is limited by 31 (on 32-bit platforms) and otherwise
>> > considered to be Undefined Behaviour. Also the code uses only
>> > the first 64-bit word for the value, and anything bigger than 63
>> > will be also subject to UB. Fix all this by modifying the code
>> > to correctly set or clear the respective bit in the bitmap constructed
>> > of 64-bit words.
>> >
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Perfect, thanks!
>
>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Thank you!
>
> Bart, since you picked up the patch in the same lines of code, feel free to
> take this one on top (I think it's your gpio/for-current branch).
>

Don't you want a Fixes: and Cc: stable tags?

Bart

