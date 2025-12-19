Return-Path: <linux-acpi+bounces-19716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1BCD072D
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 16:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09CCF30B7C2A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Dec 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CB8329388;
	Fri, 19 Dec 2025 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JrT7uXZx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EU6N1hQn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FAD325492
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156717; cv=none; b=PVFzbCH5TJ6yEWN2c6zgt3BrlaberSlzMXLy8Ul1q1rokocCftjlHIrPUaBguuL3nv6gHZMGW8up6O3atpkK+Q/Rg3UK9jVb2P5j90wZwOu4jabjSerdmeAVc/oQvSiEhxsoMnQNF9h0PKIbhf5TLzFFL+sjiivJ/qmBEIpv0L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156717; c=relaxed/simple;
	bh=JzQT/NtUVd2ORVFQ2U/bDKhVUcQjuET+Od9RvZC5XGA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PBi24b57Sb+NofuFV5uQ+ebOCeNRnHw3cWZLaBdKP7MLnBqGJu4jHni1E+QZoeFnzYItZi4tnhT4cahiaa8mRzuf0DZrLl+5zi5Fpzvh8d8cagG7VG4SKyYuiOiSD3rUUflx6/Pxk6EXHyX4l7nLoAhfD3kc/05SDwNN/QyDo34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JrT7uXZx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EU6N1hQn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBgrOi3700883
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 15:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hyPkgDMn/MnopwxbaLBNTvT5oHT9fKr6kLbD6Kdh7D0=; b=JrT7uXZx4Sr8OVYg
	eWEKi3F0dXYVb/FM7RKP1cijKxQ/iHvfnNKrDAO+4P4qycDiAIBD6vLR5qmeFmQg
	plcMLXDAx5/qwymq62xJ6OyMiLFDesXrKpInYFM9r3SZfUgUwRyxYpGHxZ9whTIk
	7uu70kDZg/XGDqYF7gvGzs+42lfV+tD2cMnXTFX2KZ9K54OcPlJUBkF+RJtaVtcQ
	z0qqXLTaAREWVTrIsfUmzlVu0imv2sINoufegd0S3kp0jDHCQj0l8CkYADtyeHCp
	WgJPUdTZSBnapW2+EYtywxewU/75mllWPZNQBUUfNXs7UKF9Z4aZJk5pTSLqG6Yk
	vz7Jjg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2ejyqy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 15:05:14 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-65d12f446c2so1087163eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 19 Dec 2025 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766156714; x=1766761514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hyPkgDMn/MnopwxbaLBNTvT5oHT9fKr6kLbD6Kdh7D0=;
        b=EU6N1hQnpX4iiUr1v/bPeqboQ2h4BUGSQhx0z3JEa9+nxx1lmVwsMj1PE4bJYpaVgo
         +B9Dihja3HmXmjBOgEKmhvItNRqCx+Jr1j51o9TmfdnGXn5b+skkzf5A89d5KLczywuh
         tUjbzrwpwG/LiZDXdV12RsWOMxcYeYEmnnMpR/3YPmWNNnFHRRmYmNujYqbtTu8w2kmP
         Z37zVsRDu6bNtUtMuOAKh19En0+ursOruzfB0iAJEmHIxN60LV3MrFvJlIwvoBuwVudq
         SrSsoKeCJN0KFDhjeDK5pWDKHXL9pXGtbTvGtC5bw47jj23yCQuqGr1d0ZtyWSrru1d5
         +TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766156714; x=1766761514;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyPkgDMn/MnopwxbaLBNTvT5oHT9fKr6kLbD6Kdh7D0=;
        b=wJoG/nVyXn+FM6pX9l4URZeIDMT38YMlqkxcPtV5H4auNKrXDEFJsZi+xxyQGzlwEM
         WZbQmt0ikceL1W/LWMSAUBX8kmpNMl+jfTz2qtCVEDEFt1APmk3deoa9jJ6nnmRlcjcL
         /FATTtlvsigaTkV+LyLh/nIP6kAtlQw76/HQGXzw+g41AO+Y20Wae3rSY8/LaeSSI9R/
         nsxyyPezIJ/RpmTP1GjG4L3UNAfCz9EvPSw1IUo8vn7Jz9xwLfxzwdTUz+iaTxDnMDlT
         9GPjovtPVCXYUb2lsgBRLyN0ec6Wfik3H/xtALmjzs3iVtLErZpNmtPOpXU9Bo7TU0H2
         efNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdBHCcO3hzbjYmcHhu/jt1h5q+BePHe8JaO5DFEhLVpo3ZV7pB4PVms9TxG9nSIxoPYdxljVRmHHxC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvq9uEK8vUWNe9uo4rNCO2E6QVdEiZXR7Uu4g5D0SsvbtWPeUh
	giGcIC07q6LAs72dPT6OQbzdBIuIJm2bY40nieUh4+OjqIke2KwBPIF8sUU9Yh0KXC+Ti5B4+fT
	TFJUradLKYQ1ItKdA6H5aurBDMH5+Hn15KG2tmYq1hLzgXFnjyNn4oIarj2e/9UWz
X-Gm-Gg: AY/fxX6gNmpK7YTSNN0ZCAoe9DEIY0PvKHlj+0V+h/4wJX3Ytkq0iHYAxFse+Z5ydvo
	lyWvZ73gBfWrgM83WHq+yI8IvQapNtD3kMU7Q8UTC+fZjlkL2m36R9/bs6byjuHjBKUsqf85su5
	8CdlRwn7NXH+FgF1LB/v51ulUGyUxbXzP27uYPBfGS9rlg2+l0ahH2JUdkdP1A9rFL7J/NvIdPs
	fkNaKwbpadyRggy8mDBTilgV4mZsdsoKB2CY/p5Zgp3YXHCM9QXUbCSz6sxwNKHO5oqpHUBfkhF
	ra/yePb6W4H6JI027n5TYcLsCCHzDSTaxPNlcdbj2hE9LTte1pZEqrp6CsnwwPNqNHMpTdz1HXs
	F6mDQ3c5v+VJHg0LwQeS0SKL7gSd/WUbgjrwSYNvUdrnwCqtUI3qyTm3IRBaD0UshJfRqCPh1Xj
	3EONbOGLOkkY1lYTsdODT3FqN7tZK/rKn4mjQFoiRq9KSfvqs8wQNzAjeV00AwW6yEIBY3+XQJ7
	wVn
X-Received: by 2002:a05:6820:16a7:b0:65d:a21:d1ee with SMTP id 006d021491bc7-65d0ea5b641mr1457077eaf.23.1766156713750;
        Fri, 19 Dec 2025 07:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1gRQg9YXoN7VVxE423HZMBksLPSR7QBgFUhic0mQqygRzSXkJPLsd8xwEFkYJsS1XCMv3gA==
X-Received: by 2002:a05:6820:16a7:b0:65d:a21:d1ee with SMTP id 006d021491bc7-65d0ea5b641mr1457052eaf.23.1766156713371;
        Fri, 19 Dec 2025 07:05:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9159a4eesm2341064a12.24.2025.12.19.07.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 07:05:11 -0800 (PST)
Message-ID: <7d04ba37-b505-4207-95c3-b0ffb0736ea4@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 16:05:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH 1/1] software node: Also support referencing non-constant
 software nodes
To: Mehdi Djait <mehdi.djait@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-acpi@vger.kernel.org, Kenneth Crudup <kenny@panix.com>,
        linux-media@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <af773b82-bef2-4209-baaf-526d4661b7fc@panix.com>
 <20251219083638.2454138-1-sakari.ailus@linux.intel.com>
 <erf3c6r46lscxeqj3iqc24rkzpuuwrdhob7isva523pxtxtoy4@45gxuhkdbubx>
Content-Language: en-US, nl
In-Reply-To: <erf3c6r46lscxeqj3iqc24rkzpuuwrdhob7isva523pxtxtoy4@45gxuhkdbubx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: G2AaRlQgNKO_VCz-UB8euRuqa7ETOdD2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyNyBTYWx0ZWRfXyCUvjEhwwg4R
 6v71xF06MRhs3POHTlhPOY5VUqrOxWXM26DbXjvH+EXLb9dBvRqNAJ4FQo4LyzY3rtAB/aVC4ss
 Jvixh/0IJeZgGrtygB25rCYtW8Q73QBfidnYT0gOPuwnws/vJAIHCpqeOHrGOt267L+OntUqKIV
 J3GkQhhvAlbgtlEn4qdF2lkdFbua6ABknuEvczA4XetyejDaSeXTpeBQ72J0XRIBnCcXjCMQNcV
 Rxtvb1teANA3IHGq2ymL513TyDyNpxLx5KZWnFJS8xrkFe34lqZBGD1OUs+Rbf0GNqEBpg79jOo
 sduSa2tlXWyfM4U9A8S4nXBRlNMITLuNhdBimFOrYXj0ISE4hwQJi7L/kzo3M2x9qyLXo90gKOu
 +gcM6/vr3ZZmOAbszQojIlokD3eAiG5w6YRaI6mxpOThARVSKXpkPsDhX9ubCAr/LHNEaPb/0Ui
 +SBGn2H0Dlkhmoujj2w==
X-Proofpoint-ORIG-GUID: G2AaRlQgNKO_VCz-UB8euRuqa7ETOdD2
X-Authority-Analysis: v=2.4 cv=EabFgfmC c=1 sm=1 tr=0 ts=694569aa cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=FVsJegLj7527lu8xIQwA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190127

Hi,

On 19-Dec-25 14:13, Mehdi Djait wrote:
> Hi Sakari,
> 
> Thank you for the patch.
> 
> On Fri, Dec 19, 2025 at 10:36:38AM +0200, Sakari Ailus wrote:
>> Fwnode references are be implemented differently if referenced node is a
>> software node. _Generic() is used to differentiate between the two cases
>> but only const software nodes were present in the selection. Also add
>> non-const software nodes.
>>
> 
> it works for me.
> 
> Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 9315
> Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

Sakari, thank you for fixing this.

Since this fixes a 6.19 regression: Can someone please submit
a pull-request with "[GIT FIXES for v6.19]" pull-request to
Hans + Mauro with this patch?

Regards,

Hans



