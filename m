Return-Path: <linux-acpi+bounces-20627-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA8xFrKTd2n0iwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20627-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:17:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037668A92E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 17:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 327C83028EDA
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF082DECA0;
	Mon, 26 Jan 2026 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="BRYHe0/B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F02DB7A4
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444087; cv=none; b=YICpC/1r4oxHGZaYmaNvlnMGbKmWZvWSV1vXxNwa8JLWAL3uZ4I4ELChepRWxFr/n8XVp0ofKFcBz6xvkGNRU//N4Q0tYrWofxDGK/IVbfo3M/qc6MtyBcCdAmBeCc3BLkyubN3w1yOI/BV0USOyufk9NOKPGQjY2Qr1dhmEA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444087; c=relaxed/simple;
	bh=b8iu2qWRQsu6tc3pNc2X9ucBCRQ4P+tsRyL9+lUs2hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=qahok5Rqo+i74nflr1u0Rrhq1J3IBbno+rcnNGUHSgBc2h/p7mLjmC7VAVKjIhG2YNpiF/VtZu6uKH1eDJZSo0OkjfwjHH7VAkT/j9IxOUli4yx3nLWHEf/AkgL1XOqOiwrBzc/iWXBrlVDWwfRu4UXoRiNYVZSk3Vs/iVmRfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=BRYHe0/B; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-45c7f550f46so1440409b6e.3
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1769444085; x=1770048885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dEOLrKl+1dJwRUtD1uFFs3khzhZWFUaz5FEbEwHl00=;
        b=BRYHe0/BtgCzbZwHRIcGV+aaIJJSFtvt0sZoNP3Hyum9vk9WoQmUkeSUYL0IWxFcLL
         LfdTv355KSlZsHvHm8nsQTBdptJdltrGOpgKzWLgGEFxR0JDFApTH7nCPChGL1P900Ku
         jTfqGYFUVz+EhA5OZujPXU0kIgfoKLO8Npp58NmFqSCiL6QbE/1bkCOI9b3PPFkl7RQE
         RcrcFSOSwC5A2eXb4Ec3sDGFxTGwQEgmaKAs4Gc5KpVjbdJVrfPljbA+3FsBq1D4ePyq
         +NoS0ENnqoLvf/t4+WBVJcWoDID7R2tE9nRnC2eBdVVXLdgv3gU9Qi/5gBBft8h1fCAD
         gXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769444085; x=1770048885;
        h=content-transfer-encoding:mime-version:in-reply-to:organization
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7dEOLrKl+1dJwRUtD1uFFs3khzhZWFUaz5FEbEwHl00=;
        b=NvUqzlHm2Hi92/LbHTjQcs5zAQFwtxSG7hletx+tKquF3tVK6u6q5CPXX5pdG1b98S
         suIw/XgTfA7NGVkbC9s92pQCz90VJaWoaNdm7W1sXqUNSC67x5qquHrZrZJW5nn7aKZZ
         hG+RiVSsO/KpUsRa5vLlCrKhvnebW9P5MUVvwY60tt2gcW7Veo3NX1DYcGOqavjz7Qd9
         cYNe14foI5ga6gp3DTxA2YhghtbJeh5dJWiOWkiqc2SjzDD33wFf32MU8tbSeEr7ddej
         ZM1yYyFg71eSEkgIA6Jc8zsJTgyXcYUlcrnv6lOZmWWw44qYXi7QzeeziPOVmw+8dENe
         VMvA==
X-Forwarded-Encrypted: i=1; AJvYcCUjKfFoO7Id4tBYZZLBQsN0lR66wym6PPaldF7h4dTNwjSTTuO6XlbnK0B0zQCgfOqsBsRr9mMvF/wg@vger.kernel.org
X-Gm-Message-State: AOJu0YwMo82KuvRMYA59hCLV4eTikEHNAUkLtyRNmu4spC5vchXkETtv
	at/HTQwX40GMV2BgjBvlEX1ZZUGSaL8KdOdMH8kp2QJFxgKy1G8IO26s6P2qgkrOJuzOfqx+47u
	qqciuPtvBjwxg
X-Gm-Gg: AZuq6aJdQsnTYwD16yb4DcPpnTDAzUTra/MUc7/Z4NUmObK5usH4CZiHAJRIba6Je0B
	dZ+okXHlqN4gl9XL+h5s+EMYbPs6zVb2+Kd/rcJv92JjnkdYCtGm0wKSFyFDRbxJX1pHb1NIoVm
	88EzAPwTwNPd+svBj4HmhdapQfjTd+nDh5NqXhUtfq2uCohSPAwNl8n1iQ03fuUG0jsVG657mJO
	DqdlrdVzjhanM274ue9VfcRO4gzJcL2LTd2ohWIwHz8ylGP/aY016E6b+BZ5hTVn65Irqvjw5UD
	AespA2avqfo/Bpr82ySU0sOyh7tnLAbd0jl7PlEWAd/PThVfR7DNgl/TspvNgOoA29mbNZiI6G4
	mxneYrMTO4Q2qrR2yaHLqNwN68iXo7XKGaYSNS4Yj06rSq4YlYKcuC996V6fH/bFn0u9HfYeiJ0
	9+F77yyoNFXIKT50It1ks=
X-Received: by 2002:a05:6820:c88:b0:65c:fff0:818e with SMTP id 006d021491bc7-662e045aa13mr1947679eaf.63.1769444084998;
        Mon, 26 Jan 2026 08:14:44 -0800 (PST)
Received: from kf-m2g5 ([2607:fb90:cf15:8cd3:4e09:100f:d91c:8765])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af80348fsm7389144fac.2.2026.01.26.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:14:44 -0800 (PST)
Date: Mon, 26 Jan 2026 10:14:37 -0600
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: yumpusamongus@gmail.com
Cc: arainbolt@kfocus.org, kernel-team@lists.ubuntu.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net,
 srinivas.pandruvada@linux.intel.com
Subject: Re: [BUG] intel_pstate: CPU frequencies miscalculated/incorrectly
 detected on Arrow Lake hardware
Message-ID: <20260126101437.338255f3@kf-m2g5>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
In-Reply-To: <ddfa4153-023a-4f48-bff9-6d6a211b6d52@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kfocus-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20627-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[kfocus.org: no valid DMARC record];
	DKIM_TRACE(0.00)[kfocus-org.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arainbolt@kfocus.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 037668A92E
X-Rspamd-Action: no action

> It also sounds similar to a situation I reported here [1]. My machine
> is a desktop 265K in an ASRock motherboard.
>
> The problem was fixed when I updated the firmware to version 3.11,
> which contained microcode 0x11a. That firmware was released in
> September. The latest 3.15 from Dec 29 contains microcode 0x11d. You
> can check by grepping dmesg for "microcode".
>  1.
> https://lore.kernel.org/all/53027db5-f750-4b6f-8ac5-a849dff2524b@gmail.com/

Thanks! We'll take a look at this and see if a microcode update
resolves the issue.

--
Aaron

