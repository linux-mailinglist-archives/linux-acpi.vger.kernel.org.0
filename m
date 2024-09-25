Return-Path: <linux-acpi+bounces-8398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2153985C43
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 14:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8F6B25D21
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8F186289;
	Wed, 25 Sep 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="r8MHryfv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D671850A4;
	Wed, 25 Sep 2024 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265367; cv=none; b=nsevbTStEIMPJRWjj1VBccTB9IeeB/QrXL9hBLWeE1dNQbWY6z/8h5i6GyV00H0OPymotI/eyn38zeEv80eYJkLo71ttR9bVS2lRNsMXRQO3o0BK3HozzwDI85tj34HM3f23q7z9ClccEg3Yxm2bZdVJHXI9H9bGrG5fYdT0cVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265367; c=relaxed/simple;
	bh=Saq1ytWbL2O2UmUQtgOQn5gsH8Sw4uhqIEgcR+77LUA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PZl9REfAopjpltp2LKIyAUHcjV8M39IKQWOIahKpwZ4C93d177fVdnQW72zEm9STBtpX4hltI3q5Mn/pv7yLkf9ctisBVLHU9UIWlQhBEge4WfEdkxF+EdTrUAmgrR91W+uRhip31L5jIPDlP1TquWZGaZ78aN8rHL288o5GKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=r8MHryfv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ZBbfe925IjgVYl48vJ3/udZO9EQlZq5jCOrcTEeD2tU=; t=1727265365;
	x=1727697365; b=r8MHryfvmcArGtp4Lmq2acEnGqahSSvZsWGNzbNhorgQUlr/9MrdxzwpkI6Rt
	6XSeR7uZIKp0gQ8lJsMilZb568tE2JvZURMVVlqD6PzrEOl6pk4ENuFROviL2gQiQ3XjI6o0qfveX
	hiNXOyyI2x++6YcRwqcnC+cwmAwlPMYB3KY9ukBNZrLmq/GfzhmWwBweEVDLzE3lk9GTvzarPXopU
	b0oNemyryvDAvECIOi+rOyGzSVJp3z9u6kKoVhrH6ABN65OaeL4SIXeSDM/sAY2EKpK9/rxWCyjxZ
	OevLYD0AX9m1vE3Sbq9hq1xb3gl4OwY5tHB6fPHKFqY42PzyoA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1stQcl-0008Bp-AM; Wed, 25 Sep 2024 13:56:03 +0200
Message-ID: <87cf24b3-5ddd-4532-b186-dd1dcc62f712@leemhuis.info>
Date: Wed, 25 Sep 2024 13:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Go
 E1404GAB
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Tamim Khan <tamim@fusetak.com>, linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, Hans de Goede <hdegoede@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20240903014317.38858-1-tamim@fusetak.com>
 <c73420b7-c186-4b5d-a074-961b35ed829c@leemhuis.info>
 <f79854bd-b338-458f-bc04-466376d05a65@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <f79854bd-b338-458f-bc04-466376d05a65@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1727265365;e4cb08c9;
X-HE-SMSGID: 1stQcl-0008Bp-AM

[CCing Hans]

On 05.09.24 12:45, Thorsten Leemhuis wrote:
> On 05.09.24 11:51, Thorsten Leemhuis wrote:
>> On 03.09.24 03:43, Tamim Khan wrote:
>>> Like other Asus Vivobooks, the Asus Vivobook Go E1404GAB has a DSDT
>>> that describes IRQ 1 as ActiveLow, while the kernel overrides to Edge_High.
>>> This override prevents the internal keyboard from working. This patch fixes
>>> this problem by adding this laptop to the table that prevents the kernel from
>>> overriding the IRQ.
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219212
>>
>> Thx for that. FWIW, I by chance noticed another such report about the
>> E1404GA: https://bugzilla.kernel.org/show_bug.cgi?id=219224
> 
> TWIMC, shortly after sending this mail I noticed there is another request
> for a quirk that was send to the list, bug afaics fall through the
> cracks. See here:
> https://lore.kernel.org/all/1226760b-4699-4529-bf57-6423938157a3@wanadoo.fr/
> 
> It afaics add a X1704VAP:
> 
> 	{
> 		/* Asus Vivobook X1704V */
> 		.matches = {
> 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> 			DMI_MATCH(DMI_BOARD_NAME, "X1704VAP"),
> 		},
> 	},

FWIW, noticed another such report, this time about the B2502CVA:
https://bugzilla.kernel.org/show_bug.cgi?id=217760#c12

"""
> adding this section to file drivers/acpi/resource.c helped; if someone could do an official patch it would be great :-|
> 
>         {
>                 /* Asus ExpertBook B2502CVA */
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>                         DMI_MATCH(DMI_BOARD_NAME, "B2502CVA"),
>                 },
"""

This is not a regression, but given how frequently I notice these issues
please as a bystander allow me to ask: is there maybe some way to
improve the situation so that we do not have to add all these and likely
many other Asus Laptops to that file?

Ciao, Thorsten

