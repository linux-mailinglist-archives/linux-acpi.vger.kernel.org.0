Return-Path: <linux-acpi+bounces-8675-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD69976DA
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E128E1F242E2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2024 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62EE1E2821;
	Wed,  9 Oct 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigon.be header.i=@bigon.be header.b="KQoClQ7w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D91E230A
	for <linux-acpi@vger.kernel.org>; Wed,  9 Oct 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506798; cv=none; b=PQfExEcgveePgBP1ODZx+fb815xxiLh/BAp3zsN3i0AGZVUcUAZLNMCSq8bPaHNWVRdhqgvDodRCQMrUWZRoKDeByPJFjNSE54RbtAKGbLEEL3pco62gv/TOBREGJ+QkBARlBOjTsRooPfMSVbbRHSUu5+pHFt842kvs9ZHlvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506798; c=relaxed/simple;
	bh=9iBWv71FnXAn0PrI9UfxM7QejcGpNYKajR3Al8f1nyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEs5/4mnTNhitBL2DBD9XCktRU8Z3/AmsMhQg/WtRFtWSX6eafbF4Fi9Z1BxwTNi7XON6ZdgEmZY11Dz3p1x8y4rCLaWc3xkkCI5uHTvFrtqNlulb85k7GqGbswy2sLZ976wSyPSyzON9ly7lAvXx21oYbk/D/PMXNrhTP7gjPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bigon.be; spf=pass smtp.mailfrom=bigon.be; dkim=pass (2048-bit key) header.d=bigon.be header.i=@bigon.be header.b=KQoClQ7w; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bigon.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigon.be
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XP4gD69Vnz9tq7;
	Wed,  9 Oct 2024 22:46:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bigon.be; s=MBO0001;
	t=1728506792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy89mQDq9bPf0dPzFOUxB3KKTFtnHIC4dVrtfu1xCVM=;
	b=KQoClQ7wA6oEG7qzb87udaoPLgh0AnLLWBQp9BBsUBRR9mrsLLpMekhyJUoVHbBGzJk2Wz
	T54FEHx+HqTaJhJONgiDh/JgKiH5MFBSixxZKka/OLaV6hggc9NJE9B0BTsTTyGQ6QQJfk
	lmTDXxIzTMdrm7/Jm+NZiVi3aP/Swy+esB3BUkdqo4PsI5WwIcUu1HuK1Kosa6k556xHvD
	XKkk/mZqNpMQ+14WIiwa7+taJAKuW6Oc87HvlGAKQ9OKl5CdKWOngzdFQ3UJaCdyINZlbN
	9vH8VNTOUwLH8c8x7REA+72GXOQyZEUzVmLq1HMhNkYdcT/7qu2DH820MJW95Q==
Message-ID: <434041dd-34de-49c4-8224-3bed1f6aca8f@bigon.be>
Date: Wed, 9 Oct 2024 22:46:31 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Dell Latitude 5530 battery drain in s2idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
References: <c9e29dcb-acfb-40e1-a283-4cef9b60c5b5@bigon.be>
 <CAJZ5v0jRHEj+Y1F5tmY7MYe4jY8dZ3TpDDqs+L6BS4QxfxQALQ@mail.gmail.com>
Content-Language: en-US, fr
From: Laurent Bigonville <bigon@bigon.be>
In-Reply-To: <CAJZ5v0jRHEj+Y1F5tmY7MYe4jY8dZ3TpDDqs+L6BS4QxfxQALQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XP4gD69Vnz9tq7

Le 09-10-24 à 21:10, Rafael J. Wysocki a écrit :

Hello,
> File a bug at bugzilla.kernel.org and let me know its number.  We'll
> follow up in the BZ.

I actually realize that I already open a bug about this a few month ago: 
https://bugzilla.kernel.org/show_bug.cgi?id=218500

Kind regards,

Laurent Bigonville


