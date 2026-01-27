Return-Path: <linux-acpi+bounces-20645-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DStCA6CeGkzqgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20645-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:14:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC5918ED
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F69301D683
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D6B334688;
	Tue, 27 Jan 2026 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVksprhk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QP84upLz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B217332EA5
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504970; cv=none; b=RcHfaymLJUAVGmrIElB+72m2jzXDVVI3VPjKY0ZzAhZ1OnotLU7B2nRaY4cb8g5VpD6vA8YX7mdou4zVuiHH4SbMFcsKm1VzDZWT8/JylHaZC/bHP8B/5aZaEfz+bfyi0ZVYP+n1M/daon0dn1U+PgZpw3Gf9MWHavrRioTYo4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504970; c=relaxed/simple;
	bh=qNtpkk6tT2tYFh2174jpOabl8DIqGO8VvAPpu4gVtJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ng2rTv8CTDdc1/wM9xQOu0y/l+RZSbZ2kXJfqqxVe2bLdIIpJK8drNp9fG2V8AMfo7QEcAxQLPAnyDejvsLAtPCzhq1rKi1vuF+l8z2/Xmh2HN7+gGXmNCixBpOAwxtnyolkqOANGxGMIzZjaRWVfiULExLmZMif9pH5OjQ1SE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVksprhk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QP84upLz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R4UMeq700315
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 09:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OnG2D4vi8kXrpZ512GFa1LW29rms8uSy0cZYbPBz4+g=; b=jVksprhk7xMn3S7r
	gMhVdqILhCAnugUv9tlli84uAfR4NzTJUW+B24QeLZ9u1QAQdJxdSjGlV3SsmnIT
	RikvqS+zGIXsZxspxtmIvdj5lXdWFXngdC8uNZaPYfRz6e/VO2M1Ofyq/eg53FtO
	OuatuhWu8ECIF63Y1uW3JJCstxDruMopQozIZgkRFwApGfI7sinHSVlUm6/0A/YM
	UaMi6tThLJLTFEtUcpw+tn1/cNF0fRryLIunYJMdn82/kZmtbahCF2kGpLMMiFgh
	G18Q39WR/9aU5GWZLR14XQxAlnTic2LAdMkLvTjoGn1dJioXw7FSh37ylAm7ZdAO
	FrPfXg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxew3t44d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 09:09:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ed6c849so9643985a.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 01:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769504967; x=1770109767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnG2D4vi8kXrpZ512GFa1LW29rms8uSy0cZYbPBz4+g=;
        b=QP84upLzWpZg1OLyjZk4JfORTZIeIhinpmV8GdZ7kW41BDckxKiabncxjGtluGrs1+
         9fe3qzb1nvujIIn4wBQn6UsXgmwHeTbbmpdGwBA/SN1si+JgFTA1uMTtIsrxJCDk1re6
         LQe0v2Caf0zynZut1pCafY/xJN4Lu6B1dGGieROHXU7CFE5CmqTAhOi5yIQOtukpw+AG
         EGoAp7hggSOAeflSRJmVZ7H8gfjvHEjsqvZOxVxsDABJZ5XAoVP9PDQfehbYEQVhvbOD
         kwBNcChP8z4TZNzD0fcYzlwOAGN2GeCDIajmoIuMzY87BQ3T6Hzy4Yfx20jvnv4Wi5Il
         T1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504967; x=1770109767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OnG2D4vi8kXrpZ512GFa1LW29rms8uSy0cZYbPBz4+g=;
        b=SlnjDAjHRPFtVUIuzPQ2RS3sQ/e4v+yLuEQ7eekpuR5S+i7oGnQbSR+bl9coCg/npx
         PNuiJCgtkefyJqVfCXlvkzFdNhLY6yYzeCnjfiIvTyNRo98TycgFYGyDM89QeRiTV9rT
         QsgIYcpgNfjfwUtaGaontxI7zEsnuBEVI5HES9ont3To8nMyyt7AFvXQPWZmyZQsfgt0
         dcdLbenxH8czWu8oepf+rl0EdRrEC2f5Z6BnH3dvXfnlZ6R3TvduqS1hc+7s1BkeHYA8
         9sUinFbgRs5ZLhG16Cn3J+Ve2RA3LjtWStycypBO60jDHFNRvBr7qvQc/8wosOI8Ue+n
         3k9A==
X-Forwarded-Encrypted: i=1; AJvYcCUQnbcsg9s3nwt3XTZA1Ivpa1UotZA3D6FtnOn/topwRJ1fDnWKQJph1OBtJRAXpK8NbUJesSehiI3H@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HOgl9so3u3YA+LNjMm2lroF92+OxThPeRSWnXpkZRkhpGW+F
	35GRQQFGImFcHauUsGzdKW9RQd2tL3kLLH2LQ+KsjtuipGvSiQQS8eSPMdZJs8tipgIuj/vjn2m
	rQDYYoP48Nb9XN90Lljm4cHrJS22RDDNd7fMxdvbVeYp4VI2JP9CjgUWPqEbsK17k
X-Gm-Gg: AZuq6aITk4ALfarDFffj7iVdVr0ar8wa5dOrNVVc48B6LbIgfk/XShb7Y0BXzQsxxpB
	QFU9ZxQS7K/Bm7gKSw29MXCVwCspXBQnnKHcNL7Dr/13Im9GyseS+O2jdgStu4+3eCyC1aPzrn+
	D80uWA7G7LUhwXVRgIjPnE1eBhpsiR2/by9pTFKNJVXeOKtL4bpjaTLJAXbPWNhBBrUZqM70JH3
	1EvwHUAorl8SgmGOmbJqD0ZJg1FWD8EXYmOtagpTVeJ+gOqIQ1R2DM1vjChybZdFM6VbUi6ucQw
	n3/jEQFYKoDqWwpAnLJdfKlfeWMy9j3NkZhnZ95bRd3VZss5pK2zvQHEJLxzWnDuMhNBkyWRmaL
	7wObNrM5k1aO0BkMU1F8r+9YwS5F3rdZFIuZsEg==
X-Received: by 2002:a05:620a:4543:b0:8a2:71d1:30e1 with SMTP id af79cd13be357-8c70b8f9489mr103017085a.58.1769504967424;
        Tue, 27 Jan 2026 01:09:27 -0800 (PST)
X-Received: by 2002:a05:620a:4543:b0:8a2:71d1:30e1 with SMTP id af79cd13be357-8c70b8f9489mr103014385a.58.1769504966882;
        Tue, 27 Jan 2026 01:09:26 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:262e:d32a:e347:8b74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804db7b434sm128163345e9.4.2026.01.27.01.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:09:26 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: westeri@kernel.org, andriy.shevchenko@linux.intel.com, linusw@kernel.org,
        brgl@kernel.org, Denis Sergeev <denserg.edu@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler
Date: Tue, 27 Jan 2026 10:09:17 +0100
Message-ID: <176950495241.13307.392282288543318435.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260126035914.16586-1-denserg.edu@gmail.com>
References: <20260126035914.16586-1-denserg.edu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zJ65fEWrEwhD0bjPT6r0_B_LNL_qeIIM
X-Proofpoint-GUID: zJ65fEWrEwhD0bjPT6r0_B_LNL_qeIIM
X-Authority-Analysis: v=2.4 cv=J8CnLQnS c=1 sm=1 tr=0 ts=697880c8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=mJ1Ix_MlU6MBsB9uRcYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDA3NCBTYWx0ZWRfX9b8N0Uvn/47J
 k/S1OpoGpd+O1pxmwGDSZF6X+RvXbFYW2/UQWWwMRATZVEf0NuY3JZspkSDlHIbWQHuw3q23pKw
 hngbPsFnjODzrQAwOXIsokj9JMJqj9umHqLpQfCRHK9WXPkML38Y4+IjpB77mKRVhwtIYssxZ6S
 /K5VfTKdUB+zesFP3vqB/PJs+NhzGo5yUb0wrlfjAwmYYisOViAWJPP6MXomLHB+d+anigAhyQU
 AAO5lRGzecuC27KV29isqybLb5nliBwSim4hoZwnOz71SzJTt5fpT37BfNE7Nk//8I086g/F+N8
 ssvmTnmK/YYBg++CmjujOIB+YkaEAitaHgsrNAL2LjsGQS55ObLN/a0L7qSHDmOqoHCRC53ZuEd
 9O+jHIjTHtEj0kBTbRtX/43YwL/3ImGc5XB5v+Ygu5us3ekKohfQk/3iBntVm76rfl4yiPpp6Lg
 yFhCUjDHe9Hi6pjKY4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270074
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[qualcomm.com:server fail,oss.qualcomm.com:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20645-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 73BC5918ED
X-Rspamd-Action: no action


On Mon, 26 Jan 2026 06:59:14 +0300, Denis Sergeev wrote:
> The BIT() macro uses unsigned long, which is 32 bits on 32-bit
> architectures. When iterating over GPIO pins with index >= 32,
> the expression (*value & BIT(i)) causes undefined behavior due
> to shifting by a value >= type width.
> 
> Since 'value' is a pointer to u64, use BIT_ULL() to ensure correct
> 64-bit mask on all architectures.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: use BIT_ULL() for u64 mask in address space handler
      commit: 59084c564c412b1d537f90bd70fa1d6bfb584e82

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

