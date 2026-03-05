Return-Path: <linux-acpi+bounces-21424-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH5xBeuhqWl5BQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21424-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:31:55 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4BC214941
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32425301A166
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3123793B8;
	Thu,  5 Mar 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy9Ztu6i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B133C3C13
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772724618; cv=none; b=kFlcot0s/lapUPZ+8DMY06dMtS/sNhUtFOgIpPpk+wGqMnmuXPEbtuQp4Rt6i39Jw3wfINgKHFK8J45Xmzvv1uOih4XNJMq24JXtrP6QjMn23xgaNs+u5aFpCiSKJRLE1vV7+uhwoYJcuuyj4NrHSRM7twHJ1Dw7jg/ZE6IoTzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772724618; c=relaxed/simple;
	bh=5WRE/XPSrU6cJHMPkRB5WenzUNFoHsrH3+n9q5GaNkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXKniXfBY1s8RWAtZVv7EkyI6YL9icizOABrXS6glqvkPcnq3909Au33giMvtiMbIlo89w7M1iKZIrx4x3z3PycthRvGitQTODmOIKv/4P3EaZume5aSuWvvOJ6KnvRKzsgTFHVBqFvC03PXOJjnryrC6apE1g2hzRVxL+7bC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy9Ztu6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A88C2BC9E
	for <linux-acpi@vger.kernel.org>; Thu,  5 Mar 2026 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772724618;
	bh=5WRE/XPSrU6cJHMPkRB5WenzUNFoHsrH3+n9q5GaNkw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jy9Ztu6i0CovBPkmfrZZr32/rVWIKNnqvbIx3ZWIABaMK4H+NRy1FmAIqheYDe8Qz
	 KDm16KDTLIlS4no2p+OCle6YfVhT/KpNG/60Dw7Oj5XhRTpb2y4SAmyVD9u4CP+V50
	 FWPgo+KBAttb2VVZnMJPEf96ev+YzkcoEWIZkV/U0SS885WipdLPuJivtsrBJbG6yD
	 DbR9SbPJ/FpOBXy+vRxENwQJRQnItgouu7yEbwuIYz5cUA3YheDUrElqFuI3mad5B9
	 WTlKon6Ugv4jQvVHvK2ZSlCqbx9D72qanpHA0bwgSiZnP4u43u3+wA/nWw9WgNomBR
	 od/qCWH65DgUw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so2127183fac.2
        for <linux-acpi@vger.kernel.org>; Thu, 05 Mar 2026 07:30:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXaW9EsfPDQJvAHqT+05z2xvWqi4BUeYD0BLoejepbbFOJ5BG8vxx29LJgQSthvzfH+WuLJFfUJhidm@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/fVEH77L/ArIqJnmEyR5rrHMkcbgZEifv5yopDeud//oYbCW
	B1CBQ2PDVCNlK/civKG5XUnQgmitODJ5aIe78wOwvaqtY7dCV4mrJ5gt8ibtSckt8mqmT8tP3sO
	pwKcLXwAJrcUKp9mUqzPZpbwylAN65bg=
X-Received: by 2002:a05:6870:1613:b0:409:71aa:aa90 with SMTP id
 586e51a60fabf-416aaef15d0mr3526779fac.0.1772724617491; Thu, 05 Mar 2026
 07:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki> <1931894.atdPhlSkOF@rafael.j.wysocki>
 <aamgVMoJPXRigcI7@tzungbi-laptop>
In-Reply-To: <aamgVMoJPXRigcI7@tzungbi-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 16:30:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ii5ZWNXKyPKj2GHBqGb-Nd_sREu40N4esXuiKNHRWqiw@mail.gmail.com>
X-Gm-Features: AaiRm53u7ZNRBqfDsGAGBhNzfofakMrAf0DfK0XRE23O2U1ZaHSdbFSI6qgCE2E
Message-ID: <CAJZ5v0ii5ZWNXKyPKj2GHBqGb-Nd_sREu40N4esXuiKNHRWqiw@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] platform/chrome: chromeos_tbmc: Drop wakeup source
 on remove
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, chrome-platform@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
	Ravi Chandra Sadineni <ravisadineni@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8E4BC214941
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
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21424-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 4:29=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> On Wed, Mar 04, 2026 at 07:43:05PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > The wakeup source added by device_init_wakeup() in chromeos_tbmc_add()
> > needs to be dropped during driver removal, so add a .remove() callback
> > to the driver for this purpose.
> >
> > Fixes: 0144c00ed86b (platform/chrome: chromeos_tbmc: Report wake events=
)
>                       ^                                                  =
^
>                       "                                                  =
"
> No need to resend just for these.  I'll fix it as well when applying the
> patch.

Thanks!

