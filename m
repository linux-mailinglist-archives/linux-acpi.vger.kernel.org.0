Return-Path: <linux-acpi+bounces-20921-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJofKYE7i2neRgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20921-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 15:06:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B3B11BB40
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 15:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFAA4301184B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Feb 2026 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6AD366806;
	Tue, 10 Feb 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRDg41uh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB2328B58
	for <linux-acpi@vger.kernel.org>; Tue, 10 Feb 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732406; cv=none; b=VYDGugaYPlWvBLSUJsqr5Iq2gN4Jz9WBuOEhYCxFWOlks+q5/fSLYzCw3EaLvMngfv6ZSpISsC5l82vc10lLNaXDo+QWpiw11Nu/D+SgLkfd6vpS4D9cwlqgaxFC4R0NmdwSu7rO0oSbyjGi8kOdz/e26KfjF8z6s97Z3uhT1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732406; c=relaxed/simple;
	bh=PSOXRdnmSomcPUT/c9SFt7VtTBoyRcwnTm2hz/JlfII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcOXc62N55XYe9W60UaqmRYXUslPVqcYV5mYhBPu62tiT/+n9wnZQI94DQxpb5VUzFn50FUIwI2qfZzZF86OYLa77woUigNh4XpiZKFCdXlMl26p4/RU2rGC7zgS9I9IZut2D9gpPkmWb0xKDs54QqQkh22eM2MIfE+y9H69gaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRDg41uh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9646C16AAE
	for <linux-acpi@vger.kernel.org>; Tue, 10 Feb 2026 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770732405;
	bh=PSOXRdnmSomcPUT/c9SFt7VtTBoyRcwnTm2hz/JlfII=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eRDg41uhY0aNU/pmjhlnJnzGOLbdl5By2K6RRegT5O3TKU4hE72Jt80tVjhmEyYPj
	 D70d68E4d7RLbo2c5+Wps4lp0Z+/5hVwjVOSko20j9JZd1syly85wVbqwmP4Fgokmz
	 bLlVAsudskCtB3VwyqhZ2pF6OqebATLSXOONzsLSMKgC7d7UvkkfRR6+9hfrnxTnMp
	 2mldF45wCWhorNWEH0Nsk3c+baSAF97bf0lvTPrDxGRorb/qpvXyfvwuq1nmOxyEuD
	 x/XgNWUG5dd0Sw63mrtNDzUcX7Z8XHIXE3BrAklQZQGf4gDq/o04d3zLS2bFjwXDWd
	 0gge/IVQUPLdg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-662f5c5507cso3735097eaf.3
        for <linux-acpi@vger.kernel.org>; Tue, 10 Feb 2026 06:06:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVm91/taLLxEB9dLksqGF0KjDiPLxv7jXc3R/VCVi0Ipwv/g/XmA2cCRPu/JibdeWqQCvSKVpUMTajl@vger.kernel.org
X-Gm-Message-State: AOJu0YztqitycL3IO3BW+eV8pmFJrFbBicSWfm+k4lQVb8qlc4CqDzw1
	OcVXpdzqgZppdtlXxzu5iAQU6MW1qu06UVFOq4DTxsASDiCuPXNMaCAqvunAZyQEcysTHd+REaZ
	r3Najul90VfogN7Kj0k9bTN+JM1BxraA=
X-Received: by 2002:a05:6820:1890:b0:672:7487:80d1 with SMTP id
 006d021491bc7-6727487838fmr1539264eaf.82.1770732404979; Tue, 10 Feb 2026
 06:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202602101943.srec8iCs-lkp@intel.com>
In-Reply-To: <202602101943.srec8iCs-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Feb 2026 15:06:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jivJBYRicOSODHEw412Se1MHG7Jc=YvA9tc90bzxzuRQ@mail.gmail.com>
X-Gm-Features: AZwV_QiCFcEZU42I5TF4owAOmQRCCikGxP_uFQsTN4INoSlRkkpnJcFx49IeoXo
Message-ID: <CAJZ5v0jivJBYRicOSODHEw412Se1MHG7Jc=YvA9tc90bzxzuRQ@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge] BUILD REGRESSION 8711f3ee7e5efcf1b795c80496b0fb68713e153a
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20921-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12B3B11BB40
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 12:12=E2=80=AFPM kernel test robot <lkp@intel.com> =
wrote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux=
-pm.git bleeding-edge
> branch HEAD: 8711f3ee7e5efcf1b795c80496b0fb68713e153a  Merge branch 'expe=
rimental/acpi-driver-conversion' into bleeding-edge

This has been fixed in the bleeding-edge branch, thanks!

> Error/Warning (recently discovered and may have been fixed):
>
>     https://lore.kernel.org/oe-kbuild-all/202602100645.LWcwIOMw-lkp@intel=
.com
>     https://lore.kernel.org/oe-kbuild/202602101417.8r6ZtJHr-lkp@intel.com
>     https://lore.kernel.org/oe-kbuild/202602101600.KhGfxuWT-lkp@intel.com
>
>     drivers/platform/chrome/wilco_ec/event.c:514:33: error: unknown type =
name 'platform_device'; did you mean 'to_platform_device'?
>     drivers/platform/chrome/wilco_ec/event.c:533:19: error: 'event_device=
_remove' undeclared here (not in a function); did you mean 'event_device_pr=
obe'?
>
> Unverified Error/Warning (likely false positive, kindly check if interest=
ed):
>
>     drivers/platform/x86/classmate-laptop.c:1025 cmpc_ipml_probe() warn: =
'ipml->rf' is an error pointer or valid
>     drivers/platform/x86/toshiba_bluetooth.c:261 toshiba_bt_rfkill_probe(=
) warn: 'bt_dev->rfk' is an error pointer or valid

Now, these two are false-positives because rfkill_alloc() returns NULL
on failure (and is documented accordingly).

