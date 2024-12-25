Return-Path: <linux-acpi+bounces-10304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C19FC67F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2024 21:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEA41882EB1
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2024 20:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1561615443F;
	Wed, 25 Dec 2024 20:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uF4NZT+0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B9C1DA21;
	Wed, 25 Dec 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735158731; cv=none; b=rH1E+mhzJ54FIKu/lCOugF2ltCVE8ehhzN4fNvnAAbLIL5bRXQrvpGt7Wi3eYZBEoPmdxXMMIcqpCctX+cVadWiE/pezysGGK7qoxB7RmWHbRTF0dbBUl5v31DV037pe1b4Af9e7VzKr+2tW+bYF+OG7umoWTcNZC8wfFO5o5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735158731; c=relaxed/simple;
	bh=N6tZbh2rxinOTZzDR/Zj9iWMCGgH9H9NNjC7z9uxuUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY4y/iVsX+0k6Gc/CwTYL8lATy7y5EQDnwZrqiPsL4Uy/ByfworyXVwfXcT8Q33cCBjhAjkQTax9ppci3mTPA3ll7ySmFc6s17QjcV+rUa6dc6LPByFKbM2SpuHe+Bwg0EYDS/UfKLH2+VO3e5rWi/e7k8l1e0c8kkbMrOtPg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uF4NZT+0; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1735158680; x=1735763480; i=w_armin@gmx.de;
	bh=Iaq3MdClClX5fgSo8glyJxrlnP7rY+yJr5h5LF24T0g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uF4NZT+0bVSQ1jxwndBOMoqzE2rYgNpebyw8iQNDPInIUHYttsx7MUvVBtA7jHRz
	 eAFMKyMJJ0+XESBLQk7PFuRIOUHpBoJSiRqUpgCZo3SfNk5+V8Op+EkWSU+CYdPYp
	 GGCXOBTGqPoeQAzx5irW75ALtEXiuKvqQyOGfD9oHWsWCzNjNhSTS2qJwC/Hz4m9n
	 OUvYA0gsay8LTocdQrFNaOrYhT9dEx6iRZA6nS7/otLvMv1JkNH7dqD7YLDfx/KYz
	 wPp1w+QXH/omFJkqM2PJbFElRqqgZLWcPCw8+ZpMxEGUSHkylcmMaeQXKM09AtBd8
	 dVkN6TZKrz1Xj9/1ZQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1tcycf2dgz-014CiD; Wed, 25
 Dec 2024 21:31:20 +0100
Message-ID: <8680845b-fae0-4bc5-8baf-0b9bbaa9a298@gmx.de>
Date: Wed, 25 Dec 2024 21:31:17 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Device managed platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 mario.limonciello@amd.com, mpearson-lenovo@squebb.ca, rafael@kernel.org,
 soyer@irl.hu
References: <20241224140131.30362-2-kuurtb@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241224140131.30362-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:X2ZirBSP3XK2hE8+PG1Fhz5nVGUOl3L0u/Uqu/+O8MysMNiD37P
 GUg39yTuIpEziNWSpZKhR3l8ActVPr5ptyLr1ve2vlCIzJAHOnUu9nLCIjGYdJi8ygVF1fz
 Pea/Ux2gCQXYHztocYpZtn97N5EJNmkSKHdV9XpMXXtTv8jHNu/RpVcCfMYHfsywwZzu19W
 Tpe1nXVeJ9xPC3lZAym0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uRNKfnT9eQ8=;vCyEhqq3kgrPN5JXNEDoaLhCQTf
 kxhf4AFjHvlMFl8BMnThWm9nVE1vdQ2pQ+/fscilfsWaReVMpFsPoQD2c+u66obrASAOYRvHa
 ieX6UQVrKVw+PXnatSo8Kj3D23T2p3B/8pP+JUB0M4DZH7boUOJ2B+vbur6QiBIw/ibCHr7Yj
 5adsfButQggDkri9Wjh/yL6XAHtQqy6Pwa9TZe4STWmCXKhaBhkbOJZRZTckApeHFx3600pWQ
 UKLbEsS7Z6LuNz5iQQ2IXZdFF1puf107mpNZV0x1Cpm15X7De2L99QMetSmRBe0KGu5DF4yb8
 YaYicq8LSufrrBr0Xmhpkc4LpuvhcDcz7FNoRKoPAXGv3s4s0+4YEusjBQpiqHSUyB2GfCbq2
 U62hlnmNxllmjE0GDPCuh5MrsUZEwT6zI63jtu3AQe8KmeGZ1vlGbAvBtRn3swbtqPkg1wlWM
 tNcGBbvms5U1q2iAg1aRwlF/u75MF4DHV0CzkSDVj9hJVcK3A650jzjBWuNC1Kd1dMLsLb8HJ
 HG6F0TmSCk8ZwKSl3Gw9m6N3t/Oyuv/HnDv2vtR05nfaVwr+xm1SrdA4IRI4X4Yn3do+Sg/Cx
 eUC+XEAYCCrslgOI7Dn7y4Mz7iB8cek5fH/DaGZDrUTr/poySJ8NuV3ImxHh7sTsiFmAH8/mU
 R25NtUrlUMgqP2vp6oEvOCdqwFkhDSqCgt7fg8EhAO5JeZ966ZzIAhs6XQNxT4j0sP6umsrxI
 OVpaj8stOfH825ZW6dqIcZTIrvEw8pswSVKFN0TJVl06wqzR0TFnPNkaMi0K+wgHy7SUd2l2H
 Iar5AbEZCKGEFYQWUvhuyUPClWtKQplduBd3QLIxN3auox5mTMrqEun7qXuiIFpYkC6TVyduD
 rrc37tAnCPc+kEbLES1tzYAn7Qg2LFGfW5v4xxlJw10pnFAfknAQfMZlBBvaJ9M0N27iBUUb3
 nfeDatpf1tqdmbL+qf6l1fCpOwnUe5bdh4seovknLDL1G9yd7pyqbQnNdVn9E7wGaSQddbYvr
 ZYQaHseqRRYfwko6qGSFS557dNIgw+sqhq23+lUWYX4a0jlMWuRoZu/4LJQW2Yua4yP9juNPY
 sbnKUDUv27O1j5K3Uz2Kvj3CUlzp0V

Am 24.12.24 um 15:01 schrieb Kurt Borja:

> Hi :)
>
> This is meant to be merged on the pdx86 tree.
>
> ~ Kurt

After thinking about it my second commit regarding the first patch is invalid, so for the
whole series:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> v2:
>   - Replaced convoluted cast with intermediate variable (1/2)
>   - Restored dropped empty line (1/2)
>   - Couldn't incorporate Armin's second comment. I probably didn't
>     understand it (1/2)
> v1:
>   - https://lore.kernel.org/platform-driver-x86/20241221070817.3764-2-kuurtb@gmail.com
>
> Kurt Borja (2):
>    ACPI: platform_profile: Add devm_platform_profile_register()
>    alienware-wmi: Use devm_platform_profile_register()
>
>   drivers/acpi/platform_profile.c           | 29 +++++++++++++++++++++++
>   drivers/platform/x86/dell/alienware-wmi.c | 10 +-------
>   include/linux/platform_profile.h          |  1 +
>   3 files changed, 31 insertions(+), 9 deletions(-)
>
>
> base-commit: 03f8e0e05510dad6377cd5ef029594d30e6c096d

