Return-Path: <linux-acpi+bounces-15619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D44B22E5F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF293AB81C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 16:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063142FA0E9;
	Tue, 12 Aug 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mV0JC1i1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF42FA0CD;
	Tue, 12 Aug 2025 16:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017684; cv=none; b=VlxIFjFkgyGL6lYvKGGx02UaSUAl99kHZ5gujAJJwwcybv04wgHY0RobIArvc2uslX4YiL+mSixuWluKoqFTe4j2jptlOzxecxQ5jquUl4wFRUnLq0drCEgX5fjZc8RpRTC6iW2geqa65hH1hx4wI8hcII3RdCN/iC3tR3y+9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017684; c=relaxed/simple;
	bh=3vOlkwtJ67glsqshpb0R+ghXN+9kbz+9Mp4a3mA/YRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6kKAMZyj8wqgX9+aGdeNaRbrSNadCWNWU6noaRObSqXZMTPL27Fp3Kz47TXKBd/QOiAdo+oaEPxGTqHzjiTJv1eTRGW4sPSWtnwvnugNQfWw+TAVbhYwIVqSTk5l9FWivr4nKGOsgd6DvUTNmsd6S0OmDmzD1Pda1kdtY3V/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mV0JC1i1; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755017680; x=1755622480; i=w_armin@gmx.de;
	bh=B7dCWzfIQ2QidyRNcu5lhkKFTVn/wu3Bv+HsjyRHft4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mV0JC1i1YDYXRjWNSHyFV5FWM7a9g+INWlP+/xNp2Kkx29WwJo+Aevo+3/c5D3yR
	 B7piivQcOIcG6A/m5fTUu7Cjj1TEs1JJpOTba8qLgzK7k3gbEt9gCCkjwJj/TxVJF
	 LMD5in2pXoQsMyS8YYsr4b7T5NDtfe3VfncOaxCxekhZDkdhK6z/3wbpShn/5ZTy7
	 0Lm6prE8jrmTZd/OPvb14WDm5WoZ9N5sO3kQsg147PoMzCEeKVlk4uvoLf219h3Su
	 gUVznJzTTkGmWrBq4NumQ5uTgFQXqpK+PcvPT6aWm5pluz0bW3Qj4oo0z2reawOpy
	 Zp+WpaPor9W72+VatA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([91.14.231.131]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1uyRIw0T3a-00X4LL; Tue, 12
 Aug 2025 18:54:40 +0200
Message-ID: <4e610854-d84c-4a59-9f83-422eafb40d6e@gmx.de>
Date: Tue, 12 Aug 2025 18:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Greg KH <gregkh@linuxfoundation.org>, Ilya K <me@0upti.me>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
 <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me>
 <2025081246-raft-tattle-642c@gregkh>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2025081246-raft-tattle-642c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iHlV0NWi6KRJk4Zd59ZNj5NBeW9pq9PtEbI4fDcFyOZ0m675Zdy
 2o0iL4zoHRrFmfnhXbj7iWY46k8YQp/g5J9N0FcOzhLFVKNx2cTNxnfDGAsE9UKzcU4DokA
 b8ncy9sYJCCOMcsTtyiLkMrKQkaLlwYk9ItgJv3UOBIyEEZRVQfLK1dHvdGIx1EoHgJ2LL5
 BEHrmilhzfz0hJxM6bZVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2cknIUFHuEU=;1+phGsZ96zwzG+D+Pinu4MLu3ib
 AUtQR09JUzmnAv8CHqCM21i1ITJ4YaXfldy3V6lauiwUcgu6EiY1EJIgU/hDjlmvm2LwgT398
 PpfCkqfYQYqsZkiHHoWn1o0g6Rtrt44Sm2f+6UzPLch1L7TqFw/xjgGDfFtoWlgzP7FZpJ2CP
 eD/00drau4l0hPbKNBF+n/lfcHQMY5QdeeaOY2cDzKXcPPOv2THAtwNZqR8NnTnc484lZez0g
 U1eh2q8uvSfXgi6d7134xzJvRFASBknuezM7X99ru32cinRrkR8PaOOuIB/g5Als5glP+SztM
 qCplLq3WVa0g3O6LHNex/bXYKzbEozgv7jif8MDxOTOCs/oun2IYbOUl5D4SPFtClu5xP8Ilz
 cod8l90cHxtFMANfeUj6K/pC+FIxjLAG3cdJdb2762RqtF+GpO7K7SeGrsqIaQyAscVgNoR2j
 glh8XZeZQvwGIAKbQ7OZNWajNoXkw5I5296hRFXDz/Fj8g+if12upCf0wXiNF6aAfojSwXdIs
 +SndvqLjAfAfczu4WakM5JCQGza1a4FCbNSbdAF3sbtFWe9pa6NFTSUFJ0QBFGyRyGtJ5tGH0
 Q0MhZLzNSF9GLNGGJ5kcMf8dAkQ4y+na1oYa9bLm+WIR1rHEgp4DOXg5s0azmDHoJQsE+rjqs
 8UC3lnrFMtSHpkP3fBLZ2LKOgCuoMBDQl53gu4bcWlV+2XldhX9p7nS0UaHeplt3Y9EV/9FQT
 dkW8WdNNbiKp3aWAdHgUeeHdsakwiLflEZLFhVavS52ohcJYTOl1lJwEE0poR1mpkXhjlwLd0
 2ROrr+7vs73xJiIqXehfy2h3x4RCtG93HKABwSTpAxsfHW89iYQ/6a9UC41ggu0b48LrBOxVf
 sP3GKGM9O7vlSVrbnhwvPXtUq4BJr7IUFcbZ0hTWzwDApxlY+pTd601aEmk3rNOezovZu6cS8
 8+9b3D59v04/9kX6Vt86mPbZgrzULJ3XK2RfU3K6KtkmVDNI3L1AFJoG84N4dJk4Q5v9rnGvd
 8Hcnq2LSfFO1zM56Qmb0Hl2NZDzRbB05nyZKKDRHI1cHBunAMYFIJJKWAnvFdv8chRlrTq1/S
 gxMFj7TN+9WDYIFWKw2trayJtrIBf576du/+gYebs0YBreADoovicsCGRB6i8VVinC6rQJq7A
 eUUi6cFIqdbB/pSCPXyQBYhF3YgemQ9lReskjwuR77Ualp0QeyAMh4y+YeW8DROqt2mhqe2gM
 vsx0Hl2csmv9zm82GD3M/qs0L9XCvO3adH2EJkPHIbPXls93Au75alUleL7riQEhhR2ovc9Zw
 H4G61Y0o3ImiShW0SMjPZL9tEsGsB0u0pTp3mc6rNu5026nHMuoI0z2kU4BL6nwJPdMIwmTD5
 65bHIGq9Cq/DINChtD33/GFDicc5P55bclnvNDKwrWfrgnYUOkOloYE+aUKQL6x8c14Qfhch0
 b2MZqeiU5iE0G41pkIQezhilK5VaLqO2AnIk4euCCH12H488Ztkj2DoC7Zo2Q1+C4A/3rIcQm
 T14EaZKXekW7FLU4ATXkLwC6hqFJ+Al3UtNP0Wv0YmxO4vJO3UxRat4mAMiBlBTgjbyX4VjkY
 8P4OPDZXIYbaWSjfbV1VbJE6P5hgCMSMO25TZwjj5gmLDP1JU1olNd8IrmC1q1he7pIOZe3N2
 uMAlTgeadGqllPFY1+ZNF6ub4Qi6ZXfxQ/MqhQCnMJnRX6fWfJRubF0OLZMC/PdqZbVIGboyG
 j8OcnxRVcBqUMadXFTs5QNHBHRYIFZU+gdQpB+00i+yWq0Alpnm70DUlE9xA9i3B1B9unk7+1
 SYhX3rICS1eHmr+z6vCoBRhBkJ+VoGdrTBKHTpGcKIHH6grSY425CXt0i6v+j0pRAudQYYd8B
 tteCww75IF0J2l4KpBEhQFhCQS+a4lKae7OPW4dwkyvjdFV84VnIruleSTNGRdCqamwt3WTZX
 D9dwv1p0vPZ8Aje1LVoO9LUpQrtu2L7JMn++4bkAY2Tkkms9T3FtVbRFzTecMnKaAuFHmLbV7
 6qavLoD8WpseuRNZwMKvbaKTkSUehw/lKX7Jqafdui8I64qfmUYAXffAjhojEeNSs+RAXUSIK
 M1mUZ+RMW5t6lTKWvvJNOgAx2J6IQG4FVDVwoDm+yD0j7SDjkYZIOVOHTSBNIWvGvZeI2gvXj
 nbVfnPe00UsSeZP0foE39JBPz9v317Xokh/mUU72WzgGDWu7EFMH7iXzKODdrIz9N909M4vwQ
 5KTcUTtVpV+6crV8yTwkS1s+HvlVfy1cF9zsvOgHdphmGQLn99AvhrfxNw/7vLyip6KdulA/B
 ZFd/1obrD6vluPel5CVhgz1zciKH7iA9oCHaOmEyNorXILu1nDNTeNrwVEo0oD3THRmkl32XX
 vIXjP4FUktGijjK37Fp3UPTeyAo54MgcWBx3SBHoFqAb7ppbNmhYeBWvnCTN7gVBtPolhCIxS
 2hAiom69H5vCFhZXGZQUPzALPjdNtbbcQELzhmsCgPFEw/kgMorutYXUFlxSlFok3Q5Fq45hk
 xP1JECvftFUVv6brAkY1c/lDkGIdbT9n69cntztfnVEOuW0QhtIWdVOLRAZDzWSHmwWxgziL3
 qS7RIKf8WV97lVrKwWMxplOw2lddplKGyI1ly54dQik0rzpSweAYKxS1ZthSReyNA8MstfaFZ
 U9aMOOAHhufvRLFq0idrtfUz5g+BafGgE2hwBcVi3LS3kmgeeqMI+QdJ3BD1u4VGYAZlUtHAX
 k/3S7+9VXNsTzctwr3R1eFIkpsf9mrt6INt6bZF552ap4JmwXteTcgAbwdo+fY9e89n0NRZbT
 NNoFOgrLAaAI3rknbVz3DAJKuJAe8rZ5QheAXNmRmeIfWHevJZHJN5IkmtVfvfBnbK46CETrD
 pqqd2ej60xABliFSGpQpZkeUmRlH+fgI5aVl+ocAhOYFSOrXY+XkRY1KQA0sEWCf6oxmEHnqz
 Trb37l5ghNkzeZmhu0/hIU7IwZ7lxnNeO5LCN6Hss0tPDdh6t/FsDaaFEgWeuEAG1PbBl1X+V
 t1mawpMXsuMA/Xp52KhOv1JBbRsFH1gnMyC7yeCe1nREdyZjV0KlS4cv4DhOaIsWWAfk16Tor
 21ayoS4PptcjAajcZz+dT3CIuzAFWhxn43T24psyzfnAqOBHQ57zkG+be6NOoMacjYizVvI0L
 foqidurQzZnUMRKkONc0ol1aWbcs8QHhyMU3XoTPAul1kVU3cXVnZcArhF5azLqn8qMXGKGfI
 UMaYE+5wkr9bnrqZTsWEu4yGJ3l5PB5BhxtAIMbtmltk5w3FCd+Cz/5z8G0UKBllx79nCxzj/
 NpthP9xIF6dhR6OZH/j1yBFlyo+NsBm5b+lljrYTrHBlgen9IEaoX1umwZgqLBqW+mU+0DkU6
 0QZY3fA/lDQcIlUrleGQ==

Am 12.08.25 um 18:40 schrieb Greg KH:

> On Tue, Aug 12, 2025 at 06:51:10PM +0300, Ilya K wrote:
>> On 2025-08-12 16:32, Rafael J. Wysocki wrote:
>>> Applied as 6.17-rc material and sorry for the delay (I was offline).
>>>
>>> Thanks!
>> Thanks!
>>
>> Tagging stable@ so we're hopefully in time for 6.16.1.
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.=
html
> for how to do this properly.
>
> </formletter>

Agree.

AFAIK the Fixes: tag should be enough to ensure that this patch gets inclu=
ded
in the affected stable kernels.

Thanks,
Armin Wolf
 =20


