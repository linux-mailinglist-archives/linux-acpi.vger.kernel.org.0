Return-Path: <linux-acpi+bounces-12663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F1EA798D3
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 01:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9E23B1A88
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA711EE7AB;
	Wed,  2 Apr 2025 23:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.com header.i=nixuser@mail.com header.b="FRC9K9ZC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.mail.com (mout.mail.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B31F1302
	for <linux-acpi@vger.kernel.org>; Wed,  2 Apr 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636617; cv=none; b=URsrE5tKMxe0s5tvS+9VPiz2VP57FbAVYUdIWgpw6GuddiSd/UQByxAMc2Ma4zm2ikSN49xI4vQUGs6JN1FAVoV2aVACnvvvT+ryfoTDDZjkBYGhnGFxfnAEcrsv4fz6isCQM9uqUxHKoe+Ho5exKpFy0e3rlYVlHdjkoggJkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636617; c=relaxed/simple;
	bh=cXpn59if8nzLmy0PFe/J9hieevkAO51ys4WV7bKv2PA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=i1RkhTtND/dPhTk1VqMgyWl6D1yW4NPNwYjj/H3z5AiO4EQ/UEg3PCo7XcfTyrv9CfR9v/c1qcj69S0v3y1HI3Mp0c24mtdkCuTK3iOtZ03ZMpzyM9In6vgDYU9vyB8NFPsWg7wbeHCmGGOmtX7dF9MwlimyvVeHxp7QAbCqJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com; spf=pass smtp.mailfrom=mail.com; dkim=pass (2048-bit key) header.d=mail.com header.i=nixuser@mail.com header.b=FRC9K9ZC; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.com;
	s=s1089575; t=1743636614; x=1744241414; i=nixuser@mail.com;
	bh=dM1wFoWBU6M6mo3m8I9+QH9Z6YMy9yNHHNJqvnK+jKQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FRC9K9ZClkWzATG33pLT98YF7XLT9GXRv7DB4H3ESirxDbfmsB8EVPuir098G3d8
	 htrgeBJqcoHVowMYw7CML4UbvEtsJnLiYz9h+Q0y+5JbBSZLmRiB8pIfyHCa7Rv16
	 ahycrd06dLL2Gh1+r7sDFjHfuTQmuRoQlypov9l74L8heEgdfsRiDaI87pzrbgiQA
	 CkzErBg7SYyVI7oeHrARQpkAYOYU/mXcCijDauMc/ewCkNDCHfXDmnNjtNdFbgXH8
	 pmR94tcwpRR2N6WJmOTLgo0U/yUMEBke38Uwylh/phYY3GbW8P7h/HQaNj9Yl43Uh
	 P6Gq2LE6BtznKtY9+g==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [10.105.108.106] ([120.155.81.54]) by smtp.mail.com (mrgmxus004
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0M71ff-1tCAHQ4Amj-011evH for
 <linux-acpi@vger.kernel.org>; Thu, 03 Apr 2025 01:30:14 +0200
Message-ID: <548ec422-e504-4171-8780-cbd83f877b3e@mail.com>
Date: Thu, 3 Apr 2025 10:30:12 +1100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-acpi@vger.kernel.org
From: Ian Laurie <nixuser@mail.com>
Subject: kernel-6.15 randomly shutting down system on bogus power button
 events
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LkgRPYl2R3cyRWpxzPrj7VupGN1mAgewRig2aNju+tegaLeIxSq
 w2J/iw+QYHs+eiXa5w9Crc9wWzQcQ2K85T2NisBtYB5AadSqqu5tOZx9q8wg2ep7/KmBFcY
 9J4qJgmJWBiXhOa1kbfbp8vIibpDCNxgO8vv2q8LI+3Kl5FWJ63/ckWQoUhPhqpb7y8IenA
 3mH0OFvqqGQ/3sTBZWTmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J281GPjSOXM=;9zlVyQO9/fcwz+dVyE1U6MwNmlg
 vkB0zaJYD+yKlaUwJ6Rcc1Ibh0NgGkmNjfzyL6xcuUzpnpBvmSRMlEjmfsE3NH5unPZ0Kpb8o
 mRD7A17Jqog92kRR+lQWHkyvJV9xxCNh6ieymgXQFijcFiLrrTLerzhpTBWjH7HQJ4vdOMi+E
 orCmXcu3Vrx8hDEyTjl9xm+QGNxGifn0gWRPCZE9FAnYeGQPx5VwNmvxKJ99RY4mjPKB8mqcC
 ax9MYYMYhgYlJ+8/f3LjpSf+QfhZbvwicp6HcAdGyozVC3TRJV+9uLZcXr98oWsBEl60covWG
 9yW+d7nrD0rcUhSWEoLYlfB3wVyA4QCCZm/rhn8/9x3ItKduchKfXhgGhaw05HnJ2tulMC7YC
 M7IZOIVcBgHRQdGLCW1emchCvY8LisHb6H64AVNtMJ3LXEQQuBPMEEt17uIF8CvqQLpZx1YC2
 573Tuh3I8xxy3rtZbBEXzXSawtYnPoXetGyy/0W4KxYWvkoSbb5LlcOwDWxD6acjJiVfBu6tx
 OIR6JsqybgzQnfbJS1jo3TcFRrSyAD/XwC6fr0fxe2pZhf32jCu+3hf+MbHdWZbDeLGXU1tCh
 VVsHjV92Bx0UBOIwKhM+j3USbg9erRG0tEFgBkLQVsPk5LbSq4bGkz80/2kLqgz6xD3jXHcCL
 OgMCT6g9BN2klSpFvlQeTKoRWEFRrYEfQDbzCxPkRO+/v/BML8sWyovK3mZwZKQ7qH4WZnxnf
 lWm+PxM/TJhjLkaAqrVvRJMmRPm5gSsmjZIdgpTsvuqE+PHNXSL4Wd9XIN0S9py0pVpzrmxNn
 HyXOu/m1Uj/WFQv7PPOviYv93rERgm3Ph277ydqGzrzs2Wsl1jVEx4XaNsLTN2CEf29tlaX5w
 i1rpxQlK9NPodvprqX0ukwhL6V3j/IsrYBfO+nbtOKbC8YdGN9V9NiuO2azx6VQc/ShfaEloW
 JXG7/NLyu9gvaj0lH2jf6qF6C3lbVcobTDKRkGqVE9jh9DhIlx2w+Tr6c2pqZryL6+pbkY/Jk
 ZOiWVQrqS3Il+EIWpjNyztyIR+4irpdwkVb1oz2iFbLtCjGLShTjn3Ct6fkKZaauyzBxeyJhc
 xJiz1KmcqCiov8ARAaPcqUbFUr30ZAyndAo2vovVvzh6uPDK6wttbBa3tgr7dtq8XrZ+tw+UN
 FoFV0jKBHCc0fxvXT0Rf/dv/EHWzOI6tm7Nb31/tlCmK54cLgBHiohF5vPu9A9OPV8FZmNuyH
 REA0ZmVPhFhi3g0ECBB5bW48YTVVJeLvvrQuc3rM71gCxc/YRew9s1slO4iPi+BUzcHzfdaWe
 OqzzFq6CiSqLx6ExLNwmq6xORIUBvNm6s+qL/OskCFdYIbfEEdkkjS7z1EzBzVNuUBfdM59VD
 icy/8E4kjLz5a4n5O7eRLzXZ4qJRKV1BXth28qOSSmbilqAl96Ied5rs3IjnNlSqPAZmV8ayF
 HzVNKJXPe8WjybvSmx/35HjXYjjQ=

I am seeing an issue where (in Fedora Rawhide) the following kernels:

kernel-6.15.0-0.rc0.20250327git1a9239bb4253.5.fc43.x86_64
kernel-6.15.0-0.rc0.20250401git08733088b566.8.fc43.x86_64

are randomly shutting the system down because bogus power button events
are being received every 10 minutes to about 2 hours.  My actual power
button generates an event2, while the bogus events are arriving as event1.

Latest available 6.14 kernel:

kernel-6.14.0-0.rc7.20250321gitb3ee1e460951.60.fc43.x86_64

does not suffer from this issue.

Using 'sudo evtest --grab /dev/input/event1' I am able to prevent the
system from shutting down and also record the bogus events.

The RedHat Bugzilla entry has more details and also links to a thread on
the Fedora test mailing list:

https://bugzilla.redhat.com/show_bug.cgi?id=3D2357044

=2D-
Ian Laurie
FAS: nixuser | IRC: nixuser
TZ: Australia/Sydney


