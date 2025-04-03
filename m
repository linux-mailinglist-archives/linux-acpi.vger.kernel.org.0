Return-Path: <linux-acpi+bounces-12672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1EFA7A09C
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BB63B02E5
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 10:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ECC23ED76;
	Thu,  3 Apr 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TGMt9W7q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931C3C0B;
	Thu,  3 Apr 2025 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674652; cv=none; b=VOai8XpGqcd10HO/KHkBhXGAFW8tnO7SjJG8zePhh0/TB70kLJgZS/Y9fYl2XfxN1hnzWJbj6+g/lRguh1bUf2d6TOYLBADqgBDPHRC5KQx50cW00YS99ILja9S7q0ci8b6uEPGjx8E8Am9zHBjID4aIn+lUa3lXORsn5fkUNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674652; c=relaxed/simple;
	bh=ZiOGN/OBjYN9SLKaZnhOxhyU1UOpniwU2ApSXRy0phU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K6BJNriPRDh6xRwnC3ETHA2fMPofHx9XZ0x0umK3aIow33Y3mbFYO/xjS9DfCB4sP9kRR8QpE4kPY77o+KJ5l299bMUsq/1PWoYySmwCyK8sQJbMmZYONEPonvvMQT4GxXNFv7nq798nACSrMovOmSi6BHkwClloVOhftyqr1QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TGMt9W7q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5339sEqC029964;
	Thu, 3 Apr 2025 10:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZiOGN/OBjYN9SLKaZnhOxhyU1UOpniwU2ApSXRy0phU=; b=TGMt9W7qrlRXQzUI
	XvGPhEWkGZNwQU8K9NNy+I5ltUafAokMz6sMKZ9bJeLPbY0ua+08ioAGyS0dYj2I
	j/BbnbtG5SYc6EQKfSLklWH9P6/+WvGQmpKlN0dJFOYx6Vtrfur1h2u/2nMU0wFi
	TBMUTrcH98yCf+qtnbwnS5naldC8AlF3d5IrOTAZ/OpA1yNdRy2ddokJUhwMtYeE
	xbxwL4T0nUn77Q0fVUQRpymEua7sa4f0JuGZ9fcvBqEx0iLrKS5C5YktIakJt8k4
	u0MOJzm8g1xEu5Ia0J/AjkiQwdEUXt8iohiYsOU+PNXooQmMarqcIFX75RMrlJ7z
	ccuLHg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rbpyycdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 10:04:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 533A43Jl016439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Apr 2025 10:04:03 GMT
Received: from [10.133.33.118] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 3 Apr 2025
 03:04:00 -0700
Message-ID: <b2f13a6d-e876-4cd2-b814-6cbc0b5f862e@quicinc.com>
Date: Thu, 3 Apr 2025 18:03:57 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] device property: Add a note to the fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus
	<heikki.krogerus@linux.intel.com>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>
References: <20250331163540.280606-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Zijun Hu <quic_zijuhu@quicinc.com>
In-Reply-To: <20250331163540.280606-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xbljt1kvYHgqpeK5RPT4rt33JbyO5TAD
X-Proofpoint-ORIG-GUID: xbljt1kvYHgqpeK5RPT4rt33JbyO5TAD
X-Authority-Analysis: v=2.4 cv=ZNLXmW7b c=1 sm=1 tr=0 ts=67ee5d14 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=owBPNj5rwqKd82W3GFkA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 adultscore=0 mlxlogscore=733
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030035

On 4/1/2025 12:35 AM, Andy Shevchenko wrote:
> + * Note, this header is not meant to be used by the leaf drivers.
> + * It provides the low level data types and definitions for the firmware
> + * and device property providers. The respective API headers should
> + * guarantee all the required data types and definitions without including
> + * this header directly into the driver.
> + *

sorry, i don't understand both "leaf drivers" and "respective API
headers". could you have examples ?



