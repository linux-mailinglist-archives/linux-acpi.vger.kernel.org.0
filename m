Return-Path: <linux-acpi+bounces-20215-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF52D152F2
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 21:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CC6230222D3
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148F4242D7D;
	Mon, 12 Jan 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="J07xRaBy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C65A41;
	Mon, 12 Jan 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249181; cv=none; b=DirKeEUtyjj5G8IkUr4w7zFL3P0nm6+YOPRAbpJfcAn49kOD2QKuFU5CdJpEMD9VIQpBLGOF8Bkce3hspBxHdDtbRm8064RTr24WqH397IBxY3SO5U6r+ApL6eIkP3XZswnTV9hDsyzvudUcKtUJcikJNaWjFQUT8cg3s7c03Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249181; c=relaxed/simple;
	bh=6fp5OJJqTmP2j8TzXW2l7HsNYtI95SFjEkuhQf32SAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaqLdC0LVKnJ7aE/+aDZ+bCtn7NcO5Po65Lb+RQrYfUsqjizKZfNERYJhtODCpOaqu5QVGLRniC5gwZw7RXKK5u2gXMO4RuPp7IEPhg6i+4AUQ156Nq+QoNClUnh4nAL9QcMKGBwGzLyqWqOOloQ1nBDlrYd6NE0IjM0Y2lKjiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=J07xRaBy; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768249173; x=1768853973; i=w_armin@gmx.de;
	bh=6fp5OJJqTmP2j8TzXW2l7HsNYtI95SFjEkuhQf32SAE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J07xRaBy4O5DVtt3Bi2v+F7UbKfs3VzolNacom35xdtjN9NCaONs9Q+O5BXJaCBw
	 tNYNpZCOYM2JtM/SZKlEtlCUM1B1CgYaejFGT5rZTE7f6EnDm8bUIj17pDo7WGqWp
	 sMXhcNz4rlcnsEc1B0LfIvRnU+i7U5/uOznsea401DoB5MeAlWesoWbcDBP51CWcJ
	 0v1I/WzGsFGf9cBy1H+ZBZOZVR3OZludoWg8fa7WP0/h6ZtCF/8SXVEYXLg5I1T1k
	 VhSeddU+B4ybAtEvrjASJIkFtjZgQd2gTMph5vYUYBcVB/lwjTlVaYC9zGrvCBynM
	 7pfKZTYWqT7dnwaN/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKUp-1vP6Hz3Xix-00OF96; Mon, 12
 Jan 2026 21:19:32 +0100
Message-ID: <23340716-847d-4360-8c63-7ee5410dd43b@gmx.de>
Date: Mon, 12 Jan 2026 21:19:31 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 0/3] ACPI: video: Convert ACPI video driver to
 a platform one
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
References: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2urZSMuMHthyV4xkECKoUYY5KJoYapE2X7zNt0Kx5DjR9guQF1r
 3NIcTUJ1SPunldloWdscbdVdI7eIs0bBgt+Ryil7YB/QARNtrcZp7K5xc2Cd3wWhYXfB5wE
 wnstQ5wokg2rqSVRevguA5QnL8aXh1UTrKB6rKCYqKKpF9dll4MOHUmGkbi6umOVsCP0Sdj
 cReeLflB/XD7MpOGCZVqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tCcU+lUSpV0=;kSP5EAZOKT4qohdVWvnZMkUrmLF
 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
 egMlPguc=

Am 02.01.26 um 12:48 schrieb Rafael J. Wysocki:

> Hi All,
>
> This is a resend of
>
> https://lore.kernel.org/linux-acpi/8617910.T7Z3S40VBb@rafael.j.wysocki/
>
> due to the lack of feedback.
>
> It applies on top of the ACPI patches in linux-next.

I am somehow unable to apply this series onto linux-next. Can you send a new series that
can be applied on the current linux-next?

Thanks,
Armin Wolf

>
> The original cover letter still applies.
>
> Thanks!
>
>
>
>
>

