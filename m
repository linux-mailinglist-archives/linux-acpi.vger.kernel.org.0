Return-Path: <linux-acpi+bounces-15478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEDCB19474
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 18:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAA7174E7B
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A8D18DB16;
	Sun,  3 Aug 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="J49Elp4C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCF13C8FF;
	Sun,  3 Aug 2025 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754237314; cv=none; b=NOYwokCZOr582XyUWI9gBvyYRMAryVjnXyuJSxWW+79Xcy5fVluzmOsVP0ReDi9FMO2pmsUc3EwzgvCYc8omLbubtCbNXSVgNjzWc4FjziLBSSAegRa7uDtxUYjrYNptkY1P2x+9/UETHlCdoCShxQAVlpurlYNcJvJpjjjqkoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754237314; c=relaxed/simple;
	bh=MoQLUpUvJfc/eKZDK9oo7+Dgx7fAF9zFyUIYKAaU4fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q3j+hfpQE3u1K2AGy9tnr0mh3aTOAbrnCMGMKtrmebboT2OE/kb241bPVkpObM4sSWY5V3a3WHir3csojByAgFA3AnIb3X7BNcXoNHmRJwGojxEMSRXubK9jpK4HiWWXDkFfmkXq5sZo6oF2TPJofg495AbemCJ/7Qe/5ruXs8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=J49Elp4C; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754237310; x=1754842110; i=markus.elfring@web.de;
	bh=QAH6qpWqSVgKW4Npr879RFNIYUnvck/RvUJvgH79mpE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J49Elp4CHNal7hH9O/ssBw4bQe39ZbLwb0EMVOBweo2V2OTU0syzDnayxpgMeqe7
	 u/kLi2gP7KZvK5uaPUalyN9YKKsxJGYC55/E8oY9wLUqrKGwLIAAhwh7NBtsjPcY9
	 k9vDmrM/gLRqsPuoZ3sfwgrEE8CdP5GPLyK4dM6dx2efAaeE1akrAXxnU2YNX/4RJ
	 Hnxz0fx8OiEiKGFNmbbG2ienpKCMtztTe5NH3QPL9+IG/q1JR+5R34ILBBrZh1BPj
	 K/+08darsgA0PURCnr6JeObCygsVJiGyLlM4U1OmXN38A4j0r3AEB1C78G52n6QzC
	 1Tisdiu/Sm584a9VoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MzkST-1uV4c30Bm5-012iGg; Sun, 03
 Aug 2025 18:08:30 +0200
Message-ID: <a62ff710-4216-4c4a-9ca1-b376a3703531@web.de>
Date: Sun, 3 Aug 2025 18:08:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] acpi: remove unnecessary parenthesis from return
 statement
To: Diksha Kumari <dkdevgan@outlook.com>, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250803153829.6545-1-dikshakdevgan@gmail.com>
Content-Language: en-GB, de-DE
Cc: Diksha Kumari <dikshakdevgan@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250803153829.6545-1-dikshakdevgan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kbE+0dHwKNFbcTHzC8kd41wRJNKbZoVoOHn844zxoHxw7XZwuEc
 TB5uJ5v0OpWHIxYpR2dLyBlyzRtocvphfryBOu0YP2sroOiXM9T/+9tdZ4JqzcdZz06N9CM
 k+YEfVsPqSeWDUT75Q2qR/GcD6vRy716NQZ+AY0GZql+e8frqziJf8qaFx79w9o1TclswKk
 1Yblk2hl3R0bC8NAS9Ckw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VAnQ94nDzG8=;5QP2F9qIuqlBWdzaYyifu79jV0a
 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

> checkpatch.pl is generating a warning when return value is enclosed
> in parenthesis. Remove the parenthesis to improve code readability.

                             parentheses?

You propose to omit also some curly brackets, don't you?


=E2=80=A6> ---
>  drivers/acpi/acpica/dbconvert.c | 43 +++++++++++++++------------------
=E2=80=A6

Did you overlook the addition of patch version descriptions?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n310

Regards,
Markus

