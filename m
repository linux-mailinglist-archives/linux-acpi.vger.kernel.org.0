Return-Path: <linux-acpi+bounces-15388-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8E7B13872
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 11:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3233AA89A
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDC5230D08;
	Mon, 28 Jul 2025 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="nkSTUiy1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E731D6AA;
	Mon, 28 Jul 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696645; cv=none; b=o/C71t8ZuVYlikbbxDDKz1/+XY4IxR5qMIC1KjfRls8WCLrS4NQB3ptf8plm4dI+dwcNiukcZ2EYQ2wPY0uQrJT3YwSaaq1MAf/X1xuB3Ke9yn4zgmBt4RJoCOBz+0RlfD0oSRgwYYl+69DD7Rx9DcB61cO/B1m3exkCom0iOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696645; c=relaxed/simple;
	bh=Rrf/eppo8NzkyzsMrgFlMQNnLJw3fN0dBCoG1NqHTa0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tGtIJlZgb9kmbKWC10U9Fw8kkA5wJhaw6AxCJmKzHSlGqDLwtcZfJ+CnFDA+bHMjnEAaLXQVr8zSM6Pqry/AJloJuTafeYOpg9x8vTe3YAQJB1xjZAAhF0JAHv3HUzBh4ZBZyJKrF4VBsdSMbR7mYqYykVdkO82z5gUKvmdlEGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=nkSTUiy1; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:152c:0:640:d236:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id E52C8C13BC;
	Mon, 28 Jul 2025 12:57:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CvU7JV6R1Cg0-tMfugOc2;
	Mon, 28 Jul 2025 12:57:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1753696633; bh=Rrf/eppo8NzkyzsMrgFlMQNnLJw3fN0dBCoG1NqHTa0=;
	h=From:Subject:In-Reply-To:Cc:Date:References:To:Message-ID;
	b=nkSTUiy1CAplAJSpvxJ/Ujei6wMbX8OE1EUhTXqlH6Vi3lfkwzZLATHV30frA9Nzq
	 McKIRllXnA4KZT927FVNonogbsvmSpX6i3GHoKJPlNfHAxM0mlYY9z8NtzFFYmqcnS
	 9WBfXjrV65hGeJcVhTVXhFuD//N6sTWcwq/h6F1s=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <9323b4ab-f2c2-41ec-be0e-779d327205ca@0upti.me>
Date: Mon, 28 Jul 2025 12:57:12 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rafael@kernel.org
Cc: W_Armin@gmx.de, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAJZ5v0iWS=tHAuauHNHb+N9_GjJTX2-RY01eAS8-sjS_2UZaoA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Ignore ECDT tables with an invalid ID string
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <CAJZ5v0iWS=tHAuauHNHb+N9_GjJTX2-RY01eAS8-sjS_2UZaoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hello folks!

It looks like this change makes the touchpad stop being detected entirely on my ThinkBook 14 G7 IML[0].

The kernel log says: > ACPI: EC: [Firmware Bug]: Ignoring ECDT due to invalid ID string "_SB.PC00.LPCB.EC0"
Which looks technically invalid, but also probably important? :)

Reverting the change makes things work again. I'm going to try a firmware update and pray to
whatever dark gods are responsible for Lenovo firmware that they fixed their ACPI tables, but
that requires getting Windows on the machine, so it'll take a bit.

[0]: https://psref.lenovo.com/Product/ThinkBook/ThinkBook_14_G7_IML

(resend -glpnk because my mail server is a shit)

