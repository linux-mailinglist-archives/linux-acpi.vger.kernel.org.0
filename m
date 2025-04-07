Return-Path: <linux-acpi+bounces-12773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D0A7D20F
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 04:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BD1188AD84
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 02:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D4212F82;
	Mon,  7 Apr 2025 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.com header.i=nixuser@mail.com header.b="Vrs8IRpI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.mail.com (mout.mail.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F72A1A8F60
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743992007; cv=none; b=RF1qZRcqSxdBL/lqo0y3mHH9jZ+eQFW7Weevi5qVywYKSajExrHHOfX6luPHbhAFh+d0kyCa4ZyDdHwRLtQdyyhAa8JMchONxmDU/4yMxqlwzvPnPGcJYKUuPHWh9sQthUn7H8tE3DqZ0mCGCuv1Bs3MEgiR1ylnmugeZXO8xHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743992007; c=relaxed/simple;
	bh=ArXCt0z1Jv+mXtLkUy2ZQa5kROOUYveJFQ7YMWCAy1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=un3Y8I9wraXv6OD/01okXulV8/PCAqc4HOJaBfrqHSMATtn3g2AlD7lgGNRGHA+hr+MzBPo4bUvIjW+K1dAO8PV6Rc8lSu3M7O/odcjDF8nJi/e+edlIWIAev+ZrXNdpdB9z/vOqLVkllIStPETDgFQ4oPVToa0vJpH39bJV44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com; spf=pass smtp.mailfrom=mail.com; dkim=pass (2048-bit key) header.d=mail.com header.i=nixuser@mail.com header.b=Vrs8IRpI; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.com;
	s=s1089575; t=1743991998; x=1744596798; i=nixuser@mail.com;
	bh=ArXCt0z1Jv+mXtLkUy2ZQa5kROOUYveJFQ7YMWCAy1s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Vrs8IRpIkVc6nN7ANacN6SWghAtgCfiVO48INmDNT4LHTGcCQWgHJ3H8t+Cpt528
	 u9amDMyby9Fek6nwXOGbquseOvSSlzmgC8MY7EC8RcC9Wzb8gluC+JvJzfCCmVqVD
	 Oe0Jvc3BEfVfBylvKMb3696eZ6NPU7MU3qh7INPUcaEB8dcIjiYkNnsiS3mqg0ct9
	 RuRorvyuhzEQi5biOYHR9U6smwQe0JgXqg62Yg+rldPYYWojV/vUfPWBoSKPBHQWB
	 ywKVLIx9DrvkAhtUkxPYsLOKCON3qtbwZ4tx90PrjufjCZ7pUVADul1XPBbimLvPD
	 NwPo8CAP7dWcYVFdNg==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [192.168.16.65] ([163.53.147.46]) by smtp.mail.com (mrgmxus005
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0LpttR-1tOPLV1jnD-00a8IR; Mon, 07
 Apr 2025 04:13:18 +0200
Message-ID: <b08a4411-0bce-412b-b69a-13c060f1d0cb@mail.com>
Date: Mon, 7 Apr 2025 12:13:14 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: button: Only send `KEY_POWER` for
 `ACPI_BUTTON_NOTIFY_STATUS`
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 rafael@kernel.org
Cc: Yijun Shen <yijun_shen@dell.com>, Richard Gong <richard.gong@amd.com>,
 rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org
References: <20250404145034.2608574-1-superm1@kernel.org>
Content-Language: en-US
From: Ian Laurie <nixuser@mail.com>
In-Reply-To: <20250404145034.2608574-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MQgLhT4nkZb2S+LAbkykGreYqWbJivl6nlXGIjL5s5OlJrAAjry
 T8nhIk/515in0IGM+mA/Z7gwT2q6XWd9k3xPGxCMTgENGZApPW3FP6164SKF3Coxx0Ag182
 k7FB7p64O0mrEtTyUWkr5GsRLisoc1MG4bWVE7AN0ZSwXjCUXN/HauEPwi/qy1TS0VoE7Hk
 RsZMEkt9jZyUlao+m7tXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Mjm4YxbUpCA=;0D6pX0ZS9/7HdaibAKoZpUjvtzp
 4EWCb/3ZptSKafWrdbzZwsw/0J9Hk0cq2O5fNx6LRnreojSovrzaYFVa36A+kEBOe1GKDMmlH
 EaY2hyX2FUFpMFOB+tLS7a/s4xjTDPB2ly6tu24veWJYoIcScpfd+MAAgPlK3fhSMxZRamxVx
 qzhFe7V+FHLXLZuSJmuBQllyb6IIoIXPutX4t0zcojk+3z2J75ewMAmtInm2kI1/HCGkg31qX
 mvewF3dqlBHUFgSn0xUJKNEmOjDeFhzT16QFXK6Syr9GOATDaohdHZW1Z7CpQl7xnph+5liYW
 x3N1PhnJYUZvD2Sr5bPnL07FAAet/pUqE5c+5CryXWC0pAe3mu1QI4f5AOczDaSum4xIsa+K0
 E2yIbUBD9E3/aJRHDQCgsEwak08WTPLAQUYguOY0ClNjAoYUON+4XVu8oRW6m6e9EV88TS/ss
 RygGqcclCy7rtBC/FiTnqnSfnke1NenJW7o9QHpECjYWVf1rtIFlX0D78Twh0OY7yrl+q0qo+
 ONC3QfjH1pyOQDf9AQH1uLpw4BBqwOeR2Y2JSCarTGKv7Byouz7utXyYFfULApN/KbrnyG87Y
 lIzI7TE542RwYFvBN/I23i2cNVRFm32babavGCEgfThJJWaZDNr3hTfnyrl9tCcpjO1IIZESj
 BLJbgmmtl+PGNGmESQM3k7i/hKCXpiXQI6a7d8ObX6dWKxZi7CLRjG/hFu2zjcFWuXuglYzB3
 IO+5wRkIE7gE+uMNiXdaWznBzTA6zZBfwmQORtBZIC6ho21UUCdTNh5yrRQ+0YDu6UZn6PHi1
 3Sg6GJHmAfjIRh2e3cY9pJ8PrUjxHQS9jaeXAGW0sGhdUIPnXLQcvUdAIDQkOkXLdBanXNOVg
 868hisg0cE/GvmmYMX7f7joN5AXGfh5TfJomSb8mi7GmbqnlAzJ7VYMiSdfmplkpl6MhWj9Cv
 QpAdhTb2xonLcDXy6GRR/DJvRL2SnOPckEEniMH8PL4/f6vFdayhyJ/KLoeyiHnbPr9R39pJv
 g714z3mAvuJwcTwZgKwMq0JnvUXyAkYCiIZpleGarZPUmkmXVGi9gjTNfhTSioW8iKVVIT6I5
 Z9GvoGd6ydcpgVruMYWuLyLbZnCuhPD4n5/52V6LLaeXECZNTq0tanRMk4mwqIEz9UtEjGJrO
 /kUwrKeVOLp+gOBnvf+atulpOvjmz1sLKq3J2JbekADVGwJPUKi2w3QGSfmtjYFM+9QGaMd1u
 3l+wpyffSGsNTZhAsv8ePrERxSBDZecmca6VBomeAD/Sfu2+Bf3Y2UfYJA3cF55PBfSiKykYK
 JQCGXYs8QqnJDP6bB+0Y6Qa0D1D7jcC1zpXhrfT1x13dPV5EJsxgOqIQdmfJujRZiEOU6iI2o
 y9Be7XvsoyWu9MPgilvQedi26iBatVoEuGVIUoQ4t/E4nsUV4gyayVG+cf92u5pm9d9G3FRNt
 FZL2+1w==

Downloaded the build Justin did on Koji, looks good after 24 hours, no
bugus events.

Tested-by: Ian Laurie <nixuser@mail.com>

=2D-
Ian Laurie
FAS: nixuser | IRC: nixuser
TZ: Australia/Sydney

