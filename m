Return-Path: <linux-acpi+bounces-20864-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEAWH7uWhGk43gMAu9opvQ
	(envelope-from <linux-acpi+bounces-20864-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 14:10:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D20F3031
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Feb 2026 14:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C5230056C5
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Feb 2026 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52E43D3CEB;
	Thu,  5 Feb 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC2UxFPi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590883A0B01
	for <linux-acpi@vger.kernel.org>; Thu,  5 Feb 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297016; cv=none; b=NlizDL4ueRfHp8AYrxKi7+pCD7dFo5o9qRCaNaGRpTnD52pbFmJMnGh2kZ+7Wv9iRvgth15DGLJmRVQM2Up4nwCHamLToR3g7n3SWhbenPJFJShBV1tcGssg7XNfpsQrjy2IcTVmyt2i1DCoQoDgZDDzW+qBytNcIfoE78oaijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297016; c=relaxed/simple;
	bh=g06hxuxEUhC4yKf7OWaLtDoSkFebbaVKoScO/qtaIEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h++8UFdLNcMggE5bL6dF/pI2EoTW4SGK+CMWllUOqTgyFMbMhREP5ayh+bbooprffo1bcDLTrKsUaDXsLnsRjjhmnJsuOLuln2xJfOKFmeiaonLRWfogXTRRuJiqnVXXnVQ98StsS27gabsucOtOOdjFRc6kGSfdY5iUhPNL4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YC2UxFPi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so10265135e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Feb 2026 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770297015; x=1770901815; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g06hxuxEUhC4yKf7OWaLtDoSkFebbaVKoScO/qtaIEo=;
        b=YC2UxFPi4+1WHeCj6ORQX2JVh+2Ew2eyUAiGFj4CSvbdKSZQDbUOhX/4gzCPTR6AQz
         9qrgOMV7y5RdhlNxKDO3OCT0x+NHw0sky0sOznKFW+PYGoqkFP1pDoOBrRo8nfAr3tOu
         sIqcFshwIzuIRI7aShgxG7XuIk6ioQ32g8k7zEExY3y4myW2aJn9rXBptYXVAHvAIcvC
         v+bKnchz4KpcQ1fBDAn/+sXbMuXdjOjuvMAxqDEafbnUA4RYWszGbkZoVVL+ViuvfrXV
         OiWWJxC/RltE0LbdSmE4+RVeQgwB7vKtDmk1hENCqinNjiY34JFbdP/K+S4eMQNZ6Zmv
         VD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770297015; x=1770901815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g06hxuxEUhC4yKf7OWaLtDoSkFebbaVKoScO/qtaIEo=;
        b=tB9QLpm1V5dLn0a1XCYDQLRKHvPIzDwWLp+7WAhdOAIuH0EmeeDFac9PnaIjKdQcnS
         6/MubNCPLE7Oj8BGN7bvws0/R9ote+BowBChxJc84S14tKyMUrP+jDsONDaHBpz9sKJv
         sY4/EUq5L6FV4kkg1ISax86uZhugacC/UZrjDkE+E7FN85eiQUfwAIz0+RJrba8al34I
         1NaGFISlANLGfsZw+4lxuOwA/FJBA+991nk8BP6US33pg9I753w8tZxcxpDcgwG6pGht
         ErIA4PhwJOUIJeGEYSU1W1TSKdxyjCj3YHITIv3Q/ZatDh2oXwouU2QxJujt0ixNLqsS
         RUMg==
X-Forwarded-Encrypted: i=1; AJvYcCViRi7JkA1OrYVVkm5rwQ5jA9Iv6TITkhzSTN5cdL1MXEXZlzvXeDrWZ7jXoWQSHOoT/OCdXQq6Wewn@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEQfhXmEnTQQITyrI445L7/hspBRfhOcKUVaxECRJOgq+ELJT
	yTL9USlS5y63EI6zaP3bJ2MVSESBP+pWPm+m5J37CSuXCZIPd8ewRYk3
X-Gm-Gg: AZuq6aLShglccSKSXV3gLfjDqqvh/F03uZI3+QBS/mUIGMx6kYGFQMKtiTymSS1GNZf
	PrU2eVWauiqTBW3DMc2NzElMoQ2/ZZfOkysIiclBrGh6zZkrxuT6YPnWfUI0vVr+KPueB6X0Kfq
	SuepiizuSO3y1vFxeaMO0AJHdlqhHxejek/VLtd+lKLlY3DGDpB2f4gd1eFRU7197lYVFR2llfk
	DNyzVFugA2fjnNzWGWZcZJf1pf4dDFhsWCjTRGE2F+2d2JG12HYTdwqy502kdj3fqiwsyWppD9d
	Q53q/wqbiHlqmWoRV4vOwY5kcyYfIspBPTngtGw7fAKedIri6qDKDX9o5ZluUWFkgXYRggDayvO
	A5MwRYCKhZ2lPWQ5eLwU5aAgsMISfrN4n91cwi2IkLnZ7OkIBjGsK9KBRe9yXvxKsNjj0N9l0Ts
	XncPG0+67j6gjpwxo=
X-Received: by 2002:a05:600c:3549:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-4830e9351f5mr99191295e9.1.1770297014494;
        Thu, 05 Feb 2026 05:10:14 -0800 (PST)
Received: from [10.245.244.111] ([192.198.151.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ffc9f3asm46238925e9.19.2026.02.05.05.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 05:10:13 -0800 (PST)
Message-ID: <acebbfddad686122c4aee9d1a87b048379dffbab.camel@gmail.com>
Subject: Re: [PATCH v7 4/7] ACPI: CPPC: add APIs and sysfs interface for
 min/max_perf
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, 	ionela.voinescu@arm.com, lenb@kernel.org,
 robert.moore@intel.com, corbet@lwn.net, 	rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, 	mario.limonciello@amd.com,
 perry.yuan@amd.com, zhanjie9@hisilicon.com, 	linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, 	bbasu@nvidia.com
Date: Thu, 05 Feb 2026 15:10:09 +0200
In-Reply-To: <CAJZ5v0gBHrGf4TpjqV+W5YynM+9_xWpepgrOiRegSYS9CvPV1g@mail.gmail.com>
References: <20260129104817.3752340-1-sumitg@nvidia.com>
	 <20260129104817.3752340-5-sumitg@nvidia.com>
	 <CAJZ5v0gBHrGf4TpjqV+W5YynM+9_xWpepgrOiRegSYS9CvPV1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20864-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dedekind1@gmail.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2D20F3031
X-Rspamd-Action: no action

On Tue, 2026-02-03 at 13:43 +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 29, 2026 at 11:49=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com> =
wrote:
> >=20
> > Add cppc_get/set_min_perf() and cppc_get/set_max_perf() APIs to read an=
d
> > write the MIN_PERF and MAX_PERF registers.
> >=20
> > Also add sysfs interfaces (min_perf, max_perf) in cppc_cpufreq driver
> > to expose these controls to userspace. The sysfs values are in frequenc=
y
> > (kHz) for consistency with other cpufreq sysfs files.
>=20
> But this is not cpufreq and it is not consistent.

Just my 2 cents to add:

CPPC and Intel CPUs don't use kHz for performance scaling. We should
avoid introducing additional kHz-based interfaces where possible, since
the performance units <-> kHz translation may become more complex over
time than today. Future implementations could involve non-linear
relationships and reduced accuracy. Minimizing kHz interfaces now may
help reduce future work.

Thanks,
Artem.

