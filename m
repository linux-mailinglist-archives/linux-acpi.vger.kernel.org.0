Return-Path: <linux-acpi+bounces-21341-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHvmOOF4qGnpugAAu9opvQ
	(envelope-from <linux-acpi+bounces-21341-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:24:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE964206437
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF53E30C3721
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD913DEAE1;
	Wed,  4 Mar 2026 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXlqQN0y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F23DBD47;
	Wed,  4 Mar 2026 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648247; cv=none; b=XIPVE1jjBFYw+3M1jovpQZST9s8JN/q6llEkAzXH9XNc0U6ce8GRpUqeFw8PfjSJqLWNm/PJ6WPKLT4S+QBCagArEf7X9WNkvLkYp4ovlS55bwjd6VK3atJKDAh7zbz8cdAk9Y4lS7fJha4vo7yoE0ucrnvr+LMfeLG0cc7sP4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648247; c=relaxed/simple;
	bh=kYdlAqCsJPZaPGGfRQepzq2wsjHZ5NwYp44Uh/Tep3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ICE51GkjCkagQRp9udHsSZ3PAo4a70rSpTqxC/7tkY+inZzYejfuAAzi9tNQbp573LoQgk6jMoVQXOeXp3lFgtmycqzq8QNH+lOMp1/GBmHK+RaOQIPZTZjWum678IvgfwwGIq+4r6vbHAyQQEFvOGMizlEEJvy7CjM77oEs0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXlqQN0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FA6C19425;
	Wed,  4 Mar 2026 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648246;
	bh=kYdlAqCsJPZaPGGfRQepzq2wsjHZ5NwYp44Uh/Tep3U=;
	h=From:To:Cc:Subject:Date:From;
	b=nXlqQN0yqjANn7UyapY7iwwoFi0VTcEHFZesq8vw4ocC4rSvg0lf4dGW2p8D2EShn
	 k0EjNCUr3Obj1JgmeKEqWRYyBEFIQRMnqGoZNqrQNxejrBQPSMCY7tiJHOxnFM6jlg
	 IQhUrbxfVmRQFUXkvjkqfu4IMKZAgwjqFHu9LKimy0l8G6rklVOXWhlsQiBxeZLChe
	 LLd5TAVRkpK79l9CnRtb6QsbQMduJrZ5WA/MYhNDASnVkhKn+Ut6xhRFeAwEjmkbrB
	 3iUx/NRteqHe49oH0j/7TAaT2TmgRJF//0DjNpL01+cGcrdW1kTQlRVXtyObimCm6l
	 96BWNn2dWyOkg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Subject:
 [PATCH v1 0/7] ACPI: TAD: Assorted improvements and RTC class device
 interface
Date: Wed, 04 Mar 2026 19:11:17 +0100
Message-ID: <5092662.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: AE964206437
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21341-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi All,

This is a proper v1 of the series posted previously as a prototype:

https://lore.kernel.org/linux-acpi/4727679.LvFx2qVVIh@rafael.j.wysocki/

The code has changed somewhat, most importantly the first patch has been
split and review feedback on patch [6/7] (previously [5/6]) have been
taken into account.

This series is on top of linux-next.

Thanks!




