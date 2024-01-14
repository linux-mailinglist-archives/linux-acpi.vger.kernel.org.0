Return-Path: <linux-acpi+bounces-2834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD782D09B
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Jan 2024 13:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91F31C20CBA
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Jan 2024 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0501866;
	Sun, 14 Jan 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="L2a64r3J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9123A6
	for <linux-acpi@vger.kernel.org>; Sun, 14 Jan 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1705236197; x=1705840997; i=w_armin@gmx.de;
	bh=WR1rAfW79pSKd4m7GDUJ3ah+zhYHTNa2RFrCYEmFCdY=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=L2a64r3JKJVuHWd9SWV2RNcJhlHAfaZvthV30cT3uiC73d8tuZiwJwYHruBgMsD8
	 Ytd6dPGuQ29fh40+vMCmyOaYZBlPmzdLksvFGk5MEd9HPImDF26kje2nP0cMLyiRZ
	 FeRJveVIc2XrhIj64gr8UQX/GoAV40n5EaUiKRGY9v/1ztF8atQrwBESK4KUjbCa+
	 mMr/1xxkaF2dWf0tViOkdYwCFxuFgf+h3MfXwgLX16bYnZyx90EkoY2DW+RzUkj3O
	 BgxbfAHeNeIl6Rb2WP1zs6ZwGT/DdXa0v7AX6n3GI0HzsRH6OTVza9D5F9teDUV2M
	 ntKLVhvKg62q9B6VAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1rRkSJ0qkQ-003svO; Sun, 14
 Jan 2024 13:43:17 +0100
Message-ID: <14c6f480-66f4-4683-92d6-55a58eb98585@gmx.de>
Date: Sun, 14 Jan 2024 13:42:36 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: rui.zhang@intel.com, rafael@kernel.org
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
From: Armin Wolf <W_Armin@gmx.de>
Subject: ACPI INT340E PTID device
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:KPoPY43LbXrZuQCoyKsi2cJNa6Iv2K3dhl85SA2Zt51z5/bqg5K
 TFePr3eArxyEH52F3RZFSWieXF0JcYAm/b6DN/w8BYfTtFRDs5+6lxWYSwQZRVgJKLJ8cY1
 +4g/96oqX9wEZ88TuOdisb2Qce0LW58oAU//mvgIViMKB6MKJtJpoi35Uk4Qf8sUYEOzFJq
 2mMigkiOQw1LtT5LWUmfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wZHhhbfVSsM=;AdhyI5J+6sMxkgWr+x6IJ/iXxV5
 1khH43/sVfLYIAtutr2pE9Ow/6x9YsGLDw6rIIYG9AzfOr29H6n/nVl24J6eAbe39752fiovD
 8PbuQ0VZVgJJHvrdiGVUHsaynb1I15S2oaInKSx0OWb6SHp9o1YVYoSG4iY5PONIJk1GpYZ8/
 6qBchUseVl59UJiy/YW6ZEBNXp1q6kJzzrYyT/IXdHIaRNX0Nb1c9rKEIm8c6AWg4eHwUbMNa
 XvMIOSSMqFiFxOJ7SKwA0lNdTzjzfp8X/42Sa1vZE1Md2pQb7tw9D5D2MuyRLymsE1YWsG/Eu
 pg36KSQClZADFvM6dy9nbEl4ngd9uDio/GVdo+RYf8xZTlufj0VhychI65nvzie3mAeRi4BR7
 HeAwUim2vzlm38kLTw+BegB/NfWwTzTb9ksHbf9+AP24djDRor2Y/eJl/Api30vYaAj2K5Cdg
 vmhRRrk+XCzSYOzIqhBxA9UEfwAZJxtvi4n7tt/SjrqK5G1qQb4oApd7Q9TW9Eqr8Lr4L1Ecy
 JhvjwfHRqHXZzC8SVZ2bW5YXUN8Mje37SXPWMMvy2PBorzN3JxEy6JUtTAhWnjh+12LcV0N2+
 8Uyq4wQ7Hd9rcaGntuAWX8KHbwy4N6tq8xKahfx+Zl2XrxANPFiUIWEdMfWlPAi/o0RPT94EZ
 emKT4hhyr7lBPiPODqQ0a3UkeShRucTyxkGDMhQFnIPg4FzP5ZmFvinzcQvnGC0uIazwI2I5O
 lAzBfMQ8mDCgnXunNsbFAhnl1S0azKr0B++EHL2kyYu6OhloT9K2mLNLnDVl9ehnANcuGN7nx
 Q4bw8ptrRuiLcwsbO8M5vhGN2TQmtKlG7+kiVelUcWyEapc3cvkU7hHfyntTWCSfP3uIiw7r5
 exQqZg3cP4jbP2scxigMEzfUmLabgHLisNOrJ5Ii2Rp1HF6Pv3mefbKYnOsWQQ4VCfCtKr+xZ
 tNQEURM+cnf1xPrKYPokOjER4u0=

Hello,

a user has asked if the ACPI INT340E device could be supported. Its seems that this device exposes
thermal and power sensors to the operating system, plus some general purpose "OSD" sensors.

The device is already supported by the Hackintosh community, see here:
https://github.com/RehabMan/OS-X-FakeSMC-kozlek/blob/master/ACPISensors/PTIDSensors.cpp

Back in 2014, the INT340E device was mentioned in message "1408622934.3315.8.camel@rzhang1-toshiba" as:

	The PTID device has _CID PNP0C02, but it is also represents an
    	INT340E device, there is a platform bus driver for this device
    	which will be introduced by myself soon.

Before developing a new driver for this device, i wanted to ask what happened to the driver mentioned
in this email? I am willing to do the testing, upstreaming and maintenance if necessary.

Thanks,
Armin Wolf


