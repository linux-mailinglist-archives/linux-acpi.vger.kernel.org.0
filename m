Return-Path: <linux-acpi+bounces-13009-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A54A87EBC
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 13:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3253AFA1B
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 11:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6B2C3760;
	Mon, 14 Apr 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="DzjMRLGL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster2-host1-snip4-7.eps.apple.com [57.103.64.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3E2C3744
	for <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629157; cv=none; b=Tq7altBISg/6So2j3yr5+OxXRGOCFi0xZlrCGUEpWfCiFNp2sQizbSYaL+UZI661S4dw6LV36HTQKl6hBCqmy76Oml8Nt+3Uw5ISBcf/ECtvtAEPaVEc/RGHj9n9EmDiBiyuRsSZKE+BB53rJbD2qXoNjQUfT+vdptSr8vrYHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629157; c=relaxed/simple;
	bh=fYOpU26jn1itnDUmzHZ0B84WsxM05tpola62kyomSCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUQyzjX0FteKvd0CIJOXdRD02JU1B27UwGrRh8jcgJglkm4lVDyidpM4+r1VKfnYDejjydBInGuuV6L4L++VrmuP5sFMNEB96q7Bai9cS9692Ffjwapos+qbuSSaY5MVP0v66CsVdCpHsdYsmCnBPOjhZS/ALkzkvI8z7ZYNNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=DzjMRLGL; arc=none smtp.client-ip=57.103.64.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=fYOpU26jn1itnDUmzHZ0B84WsxM05tpola62kyomSCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=DzjMRLGLGvES6Gj7KFuNRic4nNouz+Vi3kdpAfL/ZdtVTW7KXUNQ5VMrm92bBOm54
	 pNig8PEpJ+//ic/zWDhJbkAhwiEaCwSQOy14zsa1yDMMXsEwtcFc8HfJ/7wTe56STe
	 ejErMG2luX4KumydRMNvRcU0vGMTU3soflg5sUl1uWN41jxI3JD7cqfHEcxs5ot1Eq
	 FGpL5uM6Kxn9tZ6JQx/AByJCLID6s4PRk85OAJT8d5tOKY3hLgyP6d8W7/UIUeCXeg
	 i8S0YRHb3+DVGrXnXQ9h5xzFXNiAl/oFRVylzMk5yFLKvm4DbYAQ1GH6XnQln3COO9
	 jbE6mMW08wOFg==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id F29331800219;
	Mon, 14 Apr 2025 11:12:30 +0000 (UTC)
Message-ID: <fb77f98a-7e1e-40ac-bccb-0023da6bc297@icloud.com>
Date: Mon, 14 Apr 2025 19:12:27 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] software node: Correct a OOB check in
 software_node_get_reference_args()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
 <20250410-fix_swnode-v1-2-081c95cf7cf9@quicinc.com>
 <Z_zCeHu9MKgLG0jN@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z_zCeHu9MKgLG0jN@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FzG3iLQeVEQWKQ10CZhjf63XS721KI47
X-Proofpoint-ORIG-GUID: FzG3iLQeVEQWKQ10CZhjf63XS721KI47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_03,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 clxscore=1015 mlxlogscore=472
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2504140082

On 2025/4/14 16:08, Andy Shevchenko wrote:
> On Thu, Apr 10, 2025 at 09:12:12PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> software_node_get_reference_args() wants to get @index-th element, so
>> the property value requires at least '(index + 1) * sizeof(*ref)' bytes.
>>
>> Correct the check to avoid OOB access.
> Any real traceback?

no, find this issue during reading code.

