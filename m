Return-Path: <linux-acpi+bounces-21247-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCrSNuXyomlD8QQAu9opvQ
	(envelope-from <linux-acpi+bounces-21247-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 14:51:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C41C352B
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 14:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF85F301D053
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469852E92D2;
	Sat, 28 Feb 2026 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzyqdi73"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F92BE02B
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772286689; cv=none; b=YFCsp144qJ7lKvahuJTVg6hL5DezYhj0wqVIUSteQ8kQaef/CRt55IwDKR7Z42LVBKqG6rOd3+IIMtNv1/IkIDWGMhu0wjoTrzxFyx9dauLOaCzXEpTs8umFFn34RCREhgcFCijNarJAnyiz8ydC6MWdNyLt7nae0vuo/seBHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772286689; c=relaxed/simple;
	bh=hAvh5I5vvLzDyb4MXs00ZHj2OXgjpcoChoEZczeiLDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUWzvJxTumBlzp1W4nd25PVNHs9urwqAz/cDnW7KlND1VfP0HXIrjnnORCZcHrPF22vimN+pKySoj6nQLmMkPXMqLS7HzKekFZbcqR7nNRkKikHw+ZadC1dQWTP9Bj7MgcITC61emqCZXBdLPfkLGO75dlxCgQfqAwQYIGQ62qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzyqdi73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F53C116D0
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 13:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772286688;
	bh=hAvh5I5vvLzDyb4MXs00ZHj2OXgjpcoChoEZczeiLDc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jzyqdi73JZI5W/Ixt/0/UaGsNTDpdAjKNHQpoXwcQyPlTLHiopnDQt+kHN8noc5Ss
	 HFoftFHoipumSld60A2FDPSLphbTOnvxq0lzy84RQ62eOXm858DYZDVoWtuka1C01x
	 uN1y6K8Cyyz0UZ9ubKOfflgkQazC1PnFJNuK+MYqIvo2FlqR1oHxkLVBoE7L1JmbcJ
	 nsctOgvHoQhFJ++G2QVRj9PiWuCkUTWY2TgjUSlsrXIF1QEsPGVkFIy3zsGYYLoKbO
	 0Kt39k22NJu93Q0Fm5/grevCM6ykMC/dKOR5MSFVpG0Ay8Pe3Hdkq7MmjJbthXO0Ei
	 9QoNMff6XHihw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-679aebf4e56so2172164eaf.3
        for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 05:51:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDOUl/bJ48OHc6fM8kzqNlTNvSvJElHYeXuvpFeoQYUIpjm9Eq/dJkNBerny9lYplgaBmsYWeSij1b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63ko7HJEs/HZdANnWgquS9elCU0dt1cEG6n6AA9GlriMLD0hy
	HvNgYR3vIvDI5DdzUPcAzCF25ONzASLmQ9+kMn4owdxwVv4oJYe2xSgkt7YIkFM6OEx2upMxN61
	fmAP06ftpYlfcN6KN6hYEdRo4F5iq+cY=
X-Received: by 2002:a05:6820:4b91:b0:662:c0f7:bee1 with SMTP id
 006d021491bc7-679fae72b16mr3708733eaf.26.1772286687794; Sat, 28 Feb 2026
 05:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aW3d4B3xMwe-pyzJwFnM7q4q5WjOjAajU2c6gk65arrBx5-soWv9AAZPzZHxAiX1XOxILELauRQdnxGxMectmmW76xfxyQyErVEH8nR_iyw=@protonmail.com>
In-Reply-To: <aW3d4B3xMwe-pyzJwFnM7q4q5WjOjAajU2c6gk65arrBx5-soWv9AAZPzZHxAiX1XOxILELauRQdnxGxMectmmW76xfxyQyErVEH8nR_iyw=@protonmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 28 Feb 2026 14:51:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gL1=m6j5r3ZAp61nmwBb+wd2Y9zPSv=a=NQem5XiZMCg@mail.gmail.com>
X-Gm-Features: AaiRm51crrBewLdKqMZCJjB-mDz8DbOZ-bqCsEcCKDa9yr0HeG_2L9nwsycwn4I
Message-ID: <CAJZ5v0gL1=m6j5r3ZAp61nmwBb+wd2Y9zPSv=a=NQem5XiZMCg@mail.gmail.com>
Subject: Re: [REGRESSION] Suspend broken on 6.19.4
To: Athul Krishna <athul.krishna.kr@protonmail.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "superm1@kernel.org" <superm1@kernel.org>, 
	"sashal@kernel.org" <sashal@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21247-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email,alien8.de:email,protonmail.com:email]
X-Rspamd-Queue-Id: 123C41C352B
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 1:40=E2=80=AFPM Athul Krishna
<athul.krishna.kr@protonmail.com> wrote:
>
> Device: Asus Zephyrus G14 (GA402RJ)
> CPU: Ryzen 7 6700H
> iGPU: Radeon 680M
>
> Problem: Suspend broken on 6.19.4. On closing the lid or systemctl suspen=
d, screen turns off but device does not fully power down.
> No obvious errors in dmesg except:
> [  219.151441] amd_pmc AMDI0007:00: Last suspend didn't reach deepest sta=
te
> [  219.164301] ACPI: EC: interrupt unblocked
>
> Bisected:
> commit 6cfed39c2ce64ac024bbde458a9727105e0b8c66
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Tue Dec 23 18:09:11 2025 +0800
>
>     ACPI: processor: Update cpuidle driver check in __acpi_processor_star=
t()
>
>     [ Upstream commit 0089ce1c056aee547115bdc25c223f8f88c08498 ]
>
>     Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
>     driver registration") moved the ACPI idle driver registration to
>     acpi_processor_driver_init() and acpi_processor_power_init() does
>     not register an idle driver any more.
>
>     Accordingly, the cpuidle driver check in __acpi_processor_start() nee=
ds
>     to be updated to avoid calling acpi_processor_power_init() without a
>     cpuidle driver, in which case the registration of the cpuidle device
>     in that function would lead to a NULL pointer dereference in
>     __cpuidle_register_device().
>
>     Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle drive=
r registration")
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>     Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Link: https://patch.msgid.link/20251223100914.2407069-4-lihuisong@hua=
wei.com
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Reverting the commit or downgrading to 6.19.3 resolves the issue.
> Attached dmesg and lspci.

Is this problem also present in 7.0-rc1?

