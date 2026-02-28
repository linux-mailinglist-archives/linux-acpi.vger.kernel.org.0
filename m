Return-Path: <linux-acpi+bounces-21248-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OtMGa/0ommG8QQAu9opvQ
	(envelope-from <linux-acpi+bounces-21248-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 14:59:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3B1C3654
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6CFA301C57F
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED9C2F5331;
	Sat, 28 Feb 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqmthjp+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5101F09AD
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772287148; cv=none; b=l5Sq2B/2fvQP52IEMHTsJ4zuPufxH7fOQgZCX3hxATpeTJL954Zr4Zjkjw8XNMTlyNQy4feUvOch7ZPpn+Em7StoOD7e/D7xWXB62wnHPFq3HiJmnZhtJM0t1I/ir2STcl+ETOGk93Z5V1AXDNJd9Pzx29Q+t9YNhpFswEleWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772287148; c=relaxed/simple;
	bh=CgYxaFd0j0KjQQzwplpehLkSWDnbDoHAYGRLfV9XgFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjB7EP/EsJ9JCwz1adDHufLrfMTVxUyr3VSfti247XcED+1M4IrnMyTnk3S0CucIJLDGX1OYYJvpEgfFsyIATAULeLEEadCWhL3+bfa9aDveSa7PP1XkWqUycsZ1Z2/txM/hQa/4cyQZ+MOJ+3oUOgjQLk/DTWJJe/qa11w6tKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqmthjp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A130C2BCB1
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772287148;
	bh=CgYxaFd0j0KjQQzwplpehLkSWDnbDoHAYGRLfV9XgFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rqmthjp+5GpVbfJyvM9nb/uqlg/BkIM4rf0XHqHtrfyn6aJlgHfZyWyW6ReYXWqeL
	 QvN2AzlWxiYTf3hizU+X+RK51SABtX8AWbDVadDIC1W14lg92ETjB79/UXa4JZWR7N
	 T+5DGec52UjiQcei4hlkjexu9Wk+V//HA50IMw5XGbODSAymXedgNtGn0nFtpLa9Yv
	 qRHOxlWelg9a99o4kzy3q1CPqEz8rTYZ7QBf3Z2OysWVW+hLSn7bs7p5wSMPF8tVYe
	 jXDIL75ESXbw2Xj06L2Bmxii5VUs7uF8XAF5M7WuIvYv8AYNilq69mWvkvV/R8j9cb
	 av3lIiXYJhwAA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-67a02dcc450so693525eaf.2
        for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 05:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5vXI5Vri7pkyrInaSBJOXpDC61S0LBuUXvHUk/zC1j6GYUwTWDTrh0IdJfuj7jJnEIru6jg/XM+t7@vger.kernel.org
X-Gm-Message-State: AOJu0YyBjXGsg66x0NYif+uCwSjsdaGlX5f/ZyoPEFDlyoZAqYjnU7bO
	rzYE1Sh/73TDRBl1+NgEfNPknNS7LOV+aeE7OLL02+80IOWVFQSS/MYOsb8qMVrNwhCvM5v+fzH
	O5F+25xTKmWxGPgEp1RUJwSAKWLFAGwQ=
X-Received: by 2002:a05:6820:1b10:b0:672:9d81:a781 with SMTP id
 006d021491bc7-679fade6b7cmr4535879eaf.14.1772287147182; Sat, 28 Feb 2026
 05:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aW3d4B3xMwe-pyzJwFnM7q4q5WjOjAajU2c6gk65arrBx5-soWv9AAZPzZHxAiX1XOxILELauRQdnxGxMectmmW76xfxyQyErVEH8nR_iyw=@protonmail.com>
 <CAJZ5v0gL1=m6j5r3ZAp61nmwBb+wd2Y9zPSv=a=NQem5XiZMCg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gL1=m6j5r3ZAp61nmwBb+wd2Y9zPSv=a=NQem5XiZMCg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 28 Feb 2026 14:58:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iTJ78cR-Nub7aEvPr=9WDx_DebD0+Co9weYO99oDWTzg@mail.gmail.com>
X-Gm-Features: AaiRm51cnsS1vZ2amOQ9iZw_akWPsUJ6FMbv8XvREi-kkcwr5qZaCSxFjC0hIss
Message-ID: <CAJZ5v0iTJ78cR-Nub7aEvPr=9WDx_DebD0+Co9weYO99oDWTzg@mail.gmail.com>
Subject: Re: [REGRESSION] Suspend broken on 6.19.4
To: Athul Krishna <athul.krishna.kr@protonmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "superm1@kernel.org" <superm1@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21248-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com,linuxfoundation.org,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,alien8.de:email,intel.com:email,protonmail.com:email,msgid.link:url]
X-Rspamd-Queue-Id: B9E3B1C3654
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 2:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Sat, Feb 28, 2026 at 1:40=E2=80=AFPM Athul Krishna
> <athul.krishna.kr@protonmail.com> wrote:
> >
> > Device: Asus Zephyrus G14 (GA402RJ)
> > CPU: Ryzen 7 6700H
> > iGPU: Radeon 680M
> >
> > Problem: Suspend broken on 6.19.4. On closing the lid or systemctl susp=
end, screen turns off but device does not fully power down.
> > No obvious errors in dmesg except:
> > [  219.151441] amd_pmc AMDI0007:00: Last suspend didn't reach deepest s=
tate
> > [  219.164301] ACPI: EC: interrupt unblocked
> >
> > Bisected:
> > commit 6cfed39c2ce64ac024bbde458a9727105e0b8c66
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Tue Dec 23 18:09:11 2025 +0800
> >
> >     ACPI: processor: Update cpuidle driver check in __acpi_processor_st=
art()
> >
> >     [ Upstream commit 0089ce1c056aee547115bdc25c223f8f88c08498 ]
> >
> >     Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
> >     driver registration") moved the ACPI idle driver registration to
> >     acpi_processor_driver_init() and acpi_processor_power_init() does
> >     not register an idle driver any more.
> >
> >     Accordingly, the cpuidle driver check in __acpi_processor_start() n=
eeds
> >     to be updated to avoid calling acpi_processor_power_init() without =
a
> >     cpuidle driver, in which case the registration of the cpuidle devic=
e
> >     in that function would lead to a NULL pointer dereference in
> >     __cpuidle_register_device().
> >
> >     Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle dri=
ver registration")
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >     Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >     Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
> >     Link: https://patch.msgid.link/20251223100914.2407069-4-lihuisong@h=
uawei.com
> >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > Reverting the commit or downgrading to 6.19.3 resolves the issue.
> > Attached dmesg and lspci.
>
> Is this problem also present in 7.0-rc1?

To my eyes, this commit shouldn't have been backported to 6.19.y
because the one fixed by it was reverted in the meantime and only
re-added in 7.0-rc1.

Sasha, Greg, how do I request dropping this one from -stable?

