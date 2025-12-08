Return-Path: <linux-acpi+bounces-19484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B077CAC083
	for <lists+linux-acpi@lfdr.de>; Mon, 08 Dec 2025 05:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCAFF3016980
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Dec 2025 04:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1421915CD74;
	Mon,  8 Dec 2025 04:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PodwijK6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jC5AhOmJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF42A1BB
	for <linux-acpi@vger.kernel.org>; Mon,  8 Dec 2025 04:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765169193; cv=none; b=tH3++7Y4VNoSpFb5UK39WmNdEePQVjKWRQvKnkxL0gbhXr3LT20cRpS2+MDyLHwIiXUVkY3WUxU7O64nHJ6phBxDVIAnGg2bzaNODcbjykYXJBleH4nptX2ohlXgEqL4s3MgsaAt8lXXdnx0KYHKvSJysErEVSGoCkc4xBPoOjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765169193; c=relaxed/simple;
	bh=JzqyOmm9VLmUUGX3VI8ZodBAS9jZGkwsN+pnXgKJ77g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ejv0QhnFAENIsenNPZtTn3QgSfIp3PSH9ZzEUzG6Sjh25nQKQBZyfN1AY9/4phYneO6nXwm8TGa8aV+Y4OA/pLHPYCZFmiFrF5XBulT/Yn2/vESxgr5GdlRl8Wscp5xxx2phx9FjDG5p0VSX8BVp4o1xWW0lj4/GzROfuk+WvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PodwijK6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jC5AhOmJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7Mtr2L3768811
	for <linux-acpi@vger.kernel.org>; Mon, 8 Dec 2025 04:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p4KkJpMgIhYUsI7fBn0bWqJ3IS1cOfKstxEaPVskBgg=; b=PodwijK6PbXkrjMl
	xhkWm8YmygrdCXau39R5eVFeC3AR+1icMv+TvHeJ9tZzlaxjEVGOQhyxIZa4CGJc
	/EhhEyyE0dyDOQYPiBg4XdwEmRT12CyHTOFOjb0tF0/7aqrG3AEwtqTt0nrf4s4Z
	oVKgoZlnxJ3WKmT7PFMpAxmeBPaLIH1ocRkuf1OW1jh7SET+MWZEKvgDGzzRMQZe
	fR2r8kI7Y3GogNwPlAVIWcdLBavTweP1omzgnm9Nb7/LrO/wiVPcV069SYODNteC
	4KUcfr41UW/JdmboOvRI/Vk9m4+Qk5zJFz6vO0XaxZE+3PuxtHSRmyX5v/pt4MXw
	6amhpQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avbga3prc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 08 Dec 2025 04:46:30 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7c240728e2aso7404277b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 07 Dec 2025 20:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765169189; x=1765773989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4KkJpMgIhYUsI7fBn0bWqJ3IS1cOfKstxEaPVskBgg=;
        b=jC5AhOmJkF70Zufvz28nxZq2v7bRHpwoeKlFqGdmSk6VMWLMGpv3gKUXvhIAhclTT7
         nwNMaoHz9OpG5IZtX3HxZpM2m4oEi0h6/PNKOJrv213H4ToG0e6ZgT+OMuB3ZlwrfRHP
         cWFQz8KemRNz2X9FzNXOFOHAgErdoAgD3+rqdfljDdUwIoGhVUPyxT0H4BfQvAWlj5MB
         69bfYAeLIrz90zapsR28wcTI+ZZkGYgnxtSqFUpfOc8em7uQN1agJ6DR8qqnP9KLk7+g
         he79OTqytQYDGbGM2waeYEDBYuJCLTbAEPCnfJm+ZvdAwggScTl7uwAWKmFs6Hz48fOA
         sE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765169189; x=1765773989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p4KkJpMgIhYUsI7fBn0bWqJ3IS1cOfKstxEaPVskBgg=;
        b=vZw2YpFXXk0WzL2GPSvbCQfME55MAWKOVsjfRR/sCB5BUXnpfHiZdOSM/SnR7cvU2s
         uHYEbc+160DESFkxLhOf95AgSuuW6UTDQXWnXck8mMydpMyeE57H62lRvoIyY1drFKgt
         upKCNejQMl17XaleU2LT7tBXebbSZqmp0IWLBZygIku01brjrV/7BK9NRxsVUDoNUkSH
         QHuucXdX7AorvrA6StY7SFIa42LjKDWv+HAmivSrZn/ycFw89+5L7jq8hRQFkWsaGLpE
         j8ozQOnvJkJHPS5/mI7fiVdiro+ZZ1VktGqD542dKWzcOGh/NM84WExRA5G48+fPneuO
         TLoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Vvb9nj8Kp9RgrirHyyEu1ItRwnJkpVHCrQYNh0sYkAzp8jCLwRkwsU/Xh1qbV+iR4xyMgE3w1+0h@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVpKFUTl+Ob/6hcBLVQSFl6NbrbklIdQkMTPFAMCxe869l0Zf
	Xjn14Ou2KHO9kvgONYAFTR68tqOVCA/jg+33uysZn3QupLD6U1WAgeCxqA/l0rqCpfZ8anC8xeh
	zUdJIIap1aZBM5pgspIZ5IXE5O894EGr4WZ3pBb1Lop5A7/DnASUZR1oIv5wJPfYh
X-Gm-Gg: ASbGncufkV5t81802tkBRLtLUEmksTZxo93F3xx74dWAdYv0lPxXVcphj+SqGktU2Df
	Gy6ZtW2QNLlXC+1McQSfqQ8zCCHlrupzhe+0Yp8dSI33ze88J2vH19aTQq09IKw+MULtCHqnsqV
	p8JD4QLtqr29JamgeOyI4LnYZECjkzWyTuLAxo1wAwWMbuYsNOHbg4YkQ9tCYQ9iudbRYMhnwrw
	oLmWztUiqYpyJ+WJ+k1zUEHFaH3ctsZmU3Tnq0XtR6RRI1Bb13V+OFZgZsAyqNrUaPuvZ8VcGi6
	3Jb0EJ8spR3JfCQusjqPPpcIDRose5YRiVUT60DUK6QIhUG36ZqgKLaNUZc+Uzri02BX0sxKJVp
	Bz2/xQufDhWPxFUAI84BkwJLUBjzr6jutbSFYWkeZTh1iA+DzfhwWYB6apEEbetZB
X-Received: by 2002:a05:6a00:4fcf:b0:7e8:4398:b361 with SMTP id d2e1a72fcca58-7e8c58083fcmr6185142b3a.52.1765169189014;
        Sun, 07 Dec 2025 20:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWfbkpsiXtca8efRYKsZoQOahXUVnyACIWC1QXgJSv3ERx/JObvGwIdQQWJzPbodMInGvykA==
X-Received: by 2002:a05:6a00:4fcf:b0:7e8:4398:b361 with SMTP id d2e1a72fcca58-7e8c58083fcmr6185125b3a.52.1765169188547;
        Sun, 07 Dec 2025 20:46:28 -0800 (PST)
Received: from brgl-uxlite (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e7ecb848c8sm6946363b3a.9.2025.12.07.20.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 20:46:28 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Askar Safin <safinaskar@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        regressions@lists.linux.dev, Dell.Client.Kernel@dell.com,
        Mario Limonciello <superm1@kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH v2 0/1] gpiolib: acpi: Add quirk for Dell Precision 7780
Date: Mon,  8 Dec 2025 05:46:22 +0100
Message-ID: <176516917960.5997.17063555343335373771.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206180414.3183334-1-safinaskar@gmail.com>
References: <20251206180414.3183334-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d4z4CBjE c=1 sm=1 tr=0 ts=69365826 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Nf9rhHLrmwYAc+0rcD8p1Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=hdBtpZ1KiD_UCRkxjxQA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: Rd3OHCMJyVmPJownmiV57cpHKN11kKql
X-Proofpoint-ORIG-GUID: Rd3OHCMJyVmPJownmiV57cpHKN11kKql
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDAzOCBTYWx0ZWRfX/igJKgm9cHWK
 uucyduMC4VfE/cW2A/fIPkhMIcGk17z2Kzapt1sPCuIgHgjGwtP5K5FqNLADY7HmQMzjdX0VuPj
 l9awNtNISKXUqT7y/IZziehp8Efn6fLI0j6keRASs6onsvGvvgLRwHSMMBIrxUq5k6tCepynLvC
 lakx7l1xD0sy309ayHQ/AYeDHvTbuRirgg1SS5ovtIqLqJVOQiJQSq4adipDUY9AfGbE2lU9W+x
 oyCGSn+QQ26vhlIsVWvxGEZHERtKCbJTSQ56S+GtuzyDb/rhiX52Mn3Y3J1kw7PDrhwLV4KrMrj
 ICZWZ/jaduixhcZhwyN0PlInw8Hq4t+rvkBIBeICzkqtArMqgLyBx8KqM0SkJF1Rws4x6WX2m/k
 U2qUF/b21xzl5zlLguUdZlU1U8RB6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512080038


On Sat, 06 Dec 2025 18:04:12 +0000, Askar Safin wrote:
> v1: https://lore.kernel.org/linux-patches/20251205230724.2374682-1-safinaskar@gmail.com/
> 
> v1 -> v2 changes: changed tags
> 
> Askar Safin (1):
>   gpiolib: acpi: Add quirk for Dell Precision 7780
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Add quirk for Dell Precision 7780
      https://git.kernel.org/brgl/linux/c/2d967310c49ed93ac11cef408a55ddf15c3dd52e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

