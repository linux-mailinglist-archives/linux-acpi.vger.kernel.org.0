Return-Path: <linux-acpi+bounces-11017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F19DA30D24
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 14:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF441884C7C
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E6822371C;
	Tue, 11 Feb 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gLMyPaLZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E81214811
	for <linux-acpi@vger.kernel.org>; Tue, 11 Feb 2025 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739281248; cv=none; b=VJ7WxQjEIR26ttXSbVeRW39na8e5fF4//4yV8+hWFnome7LdA26W0GrK1eQtylmJ4cPfHa3wzmtbQ/fKjQOiVkpmF+rEtj1Z+65E6zJAIZdl+uwUyn/LDxKWJQFsBT7WNxdmCRnbscFKfXvkez+LW2nDFePaBD4TJSAaF68HxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739281248; c=relaxed/simple;
	bh=rDf1yoTRKy12ToOLrZOAZoQ7ACwfJKv8I+9q4AsypCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLQdPlwxpKv+4QcyhGAWPX7H/euGmszw5yD2Ot+S1y3esdYPJlY/igk6dATxLlnobCl9UjD7JxhdzUJsJBkhDWc0ssrZ7nvrripxDv7Kikrc3ccLNpXCxQzr5w7cQznFrUuBGjnmfaEH733UOg8XA1oXo4eBT+9s/hUruLYo2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gLMyPaLZ; arc=none smtp.client-ip=17.58.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=7z3RWlztrKg7sVSGOlVn10uKHd+0HdbTDQ77ooJEAJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme;
	b=gLMyPaLZmpYFi3srhMCrc8avKSZIouPGAmh0G/IvhgH6kxmmqYzsAJ1j5WZ3AQ4eu
	 BLYcOUCLcPzyspXRbyf2zmdKOBNxzIHvtD7XIp1FR8fIaT8BamEohVLlBpjLG6JRV1
	 pGzs+G6dV2BcSe0OSKU0qB7wPM4zsky02pZWnuDDa6XngSM4gqKqhke3yFN7vKtc4H
	 mtLpc2qK3HcPe/A8J2LL44fKVNW7k9PaW5EsXlKkCE61CbwRPK8gnKV6juQKYAstsN
	 Nc5Wmz6FBRWkopLl6GqWZJ/Gwkvr8pos4j4gilmPN030jdeBWpCsnRFTXfTdr69ihG
	 0wYtHEevDL+EA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 3174F4A0246;
	Tue, 11 Feb 2025 13:40:37 +0000 (UTC)
Message-ID: <a682824a-1b65-4b05-9e42-3edc167600a8@icloud.com>
Date: Tue, 11 Feb 2025 21:40:33 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] of: property: Increase NR_FWNODE_REFERENCE_ARGS
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Len Brown <lenb@kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20250210-fix_arg_count-v3-1-a084a5013008@quicinc.com>
 <Z6oclML_DC1Vnf6z@smile.fi.intel.com>
 <73eb84f3-8b9d-41f4-9b59-d059111a3d03@icloud.com>
 <Z6tBlfmTFu9916LA@smile.fi.intel.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z6tBlfmTFu9916LA@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TqUHXtr-ok3PC5jRlmgK0cb6DzbWQpgZ
X-Proofpoint-ORIG-GUID: TqUHXtr-ok3PC5jRlmgK0cb6DzbWQpgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=854
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502110091

On 2025/2/11 20:24, Andy Shevchenko wrote:
>>>> -#define NR_FWNODE_REFERENCE_ARGS	8
>>>> +#define NR_FWNODE_REFERENCE_ARGS	16
>>> Thinking of the case, perhaps you also want
>>>
>>> static_assert(NR_FWNODE_REFERENCE_ARGS == MAX_PHANDLE_ARGS);
>>>
>>> to be put somewhere, but I don't think we can do it in this header file.
>> thank you Andy for code review.
>>
>> yes. it seems there are good location to place the static_assert().
>>
>> is it okay to associate two macros by
>> #define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS
> I was thinking about this and I don't see how it can be done without
> introducing more chaos (dependency hell) into the headers. So, I won't
> take this path or even consider it deeper.
> 

i have confirmed that:

of.h includes fwnode.h indirectly
fwnode.h does not include of.h directly or indirectly

in theory, dependency between both headers should also be like this.

So, it is simple to use below define in of.h
#define MAX_PHANDLE_ARGS NR_FWNODE_REFERENCE_ARGS

>> OR
>> replace all MAX_PHANDLE_ARGS instances with NR_FWNODE_REFERENCE_ARGS
>> ?
> This sounds plausible to me, but you need a blessing from OF people as
> the naming may be a bit confusing (for them) as "phandle" is well established
> term in OF realm.

phandle is a type of DT firmware node reference. so this solution
seems suitable as well.

struct software_node_ref_args also uses NR_FWNODE_REFERENCE_ARGS directly.

let us wait for more comments.


