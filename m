Return-Path: <linux-acpi+bounces-19406-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C63FC9ECDE
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 12:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 004F1347048
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 11:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C112F2900;
	Wed,  3 Dec 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxDGhbRd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XXq43dyL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB102F25FC
	for <linux-acpi@vger.kernel.org>; Wed,  3 Dec 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759917; cv=none; b=J2s1AVZzbAa1lsCSK5Hgv3dgmhWP8uSuD/2oWVNt4ss9Ar1KtUewuTQTU/13ri1BWuIbgsfAVH/ON/Or+8uaa3SWny2n3dAiNJBmAmB9dzp3aIJqfCSzEAAq9WWYX03PICzKo/QEH8hwoTFO4xgEpxJmqamXrKtkGUnSGOCza7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759917; c=relaxed/simple;
	bh=ZsuShzlvrIncoG6iaWogXNnZZBAlN8E/IqA4m0xRHa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GtZgsgB2KMzjsGf6P5v29SsRujejm5GL/az/AfUsELuPzFxPiQveC6wtFjkKrC/BXXx7gVq+ZqTMup07pQStXM18Nxz5946Ivz/CvkROPjd6gOuJ0yyqQZt0M8Div/HXmu/YR9aqP9kLbVELMaM85DUHVK8g+29Az5kNvH1GKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UxDGhbRd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XXq43dyL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3B3dMl1536229
	for <linux-acpi@vger.kernel.org>; Wed, 3 Dec 2025 11:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NyEOi7qw9mdk/GOLL2dAFFxp
	5HoclXJt2QNJj2O/F1E=; b=UxDGhbRdJ2oPbDL9biErciPNxOGQFM3ekpADN5cR
	Xpv1JuDlPjUhLTijorpZub/SasIoXu9glpuVGLFwT5fgZF7N4YNPcOegKwOGsJ1b
	dy5J7jhyLojRgQgTn9fuB10E0OPw+stPC1cDD39c3WGgDSzxCUxXLmVi/7yzy7mA
	2qWN21mR4ZfkOftA+IQ53RLROljkqBsYPYaUX0ciXGfHP4jpYYdMUG80N8BLa+ro
	CatUZSIa1oGLN7NsLlQH3azEoYUqny9np0f2Wg0NqspidyHQ4RiB2V5oye/0HEfb
	7qWVWYois8eCRsrWwOt2qQGUyj9rP+PzIlM7BYkh7z4qaA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm0hr05t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2025 11:05:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b5c811d951so260982285a.2
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2025 03:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764759914; x=1765364714; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyEOi7qw9mdk/GOLL2dAFFxp5HoclXJt2QNJj2O/F1E=;
        b=XXq43dyLjvrPi2ErDkxXcRdo3uNmQ7G0Ky8JgrYh19Vnwi23JdqmG5/BDGqbcAGHo8
         eYlejWIYUDk+ag9HpSTov+XpgAVw43yriMq89KTjyqMgH9lK5W/kKTTPpCPGwBpzlNuG
         BBIynveanoaeWCaFdMOr5rLugievoN38p+MdgDOg8tCLH4olnpPFV2wcZ8pFXxiYjuAT
         mTtsHfmLuCNcjEDGgiXE2bwHX4sP38H3gbIbJUuDTsz+Yf9P3WwOC8TrgfVZPPnH3aWk
         TNMOZXsp4jUs+3JyvebtbBtWRJ8amtunXkx0Ad0Ri9TW1Ps1NgJzfRRkrM7OHHqBHg3b
         vtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764759914; x=1765364714;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NyEOi7qw9mdk/GOLL2dAFFxp5HoclXJt2QNJj2O/F1E=;
        b=NzCeG0z5vm3Z+RVw+8K9zVQojzIxV3LVss9TWZV10yoQg/NhTI333L8XtTTNakqjyx
         Xm77clNnvN0JoGBLpv9dYLIq9TwaNflVzK5RmkzJOtmM3609zkafOJ6H/tioPpMhFHKT
         BGGzI2z4myqh3fw421ZLmdO1abVhEfJkNauesK/xeZMevj4vz0jtaE7cLVFyDOe7BfQh
         H5FtUQsOjjOEpj7mhhCnoQpGQ32nAupG32ETjDQkTt3pZgCRu9S3eto30Pg3oJzGxwI4
         AXCisvi68w/rTDqw+DlHji/BuS7A8o1T6leaboMy6mwTDhLUvTMJ/jMB0S7Ugtu98RXv
         ikZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXICWdX3f85DnfUllvKnY5dOkS8f8oyoDZlP31cykZMto90YIvaC363kihpSYhuNyxP4NGmyTqIF622@vger.kernel.org
X-Gm-Message-State: AOJu0Yx80rOPsK2j+Sdk3MMyDE7Wj5VAVP2ztCb3yXxBQUHUohxn/FT/
	KImZEH/kvxnrn1va7BBg3stvaZl8qC+aL7Yv9daoV4u/thj/xkBRFspmvwelRfrfQ/rTTPlvFq/
	yVQbrS3utyPakxQsFKfiXh6S37ks+4mzjl6UEP+paEuJN1rrQmIY9GdX0HO/W7szr
X-Gm-Gg: ASbGncugISA095ZshwJLavcVQ87M557P3tIHsQbJ7sLQ01P5iNzTt/Z46DWIV5Q0QaY
	hCm2T8C03ZISW+rO2eS+Edr2sxMhNMh76gWOlqpCjFPitVc37bCAYLbMTSBDqYUbw2b0dDKCiW4
	fCtKT8aIWkTqIJ+84uV9orc7kS/UbImc25qtZx1KpVT9xoJjB5xtzxHlDvozEd2iKCeeIKIKB3+
	ljguMRMdzPlkNLxuoaQ00bcLMF4co/DkJn/C5Idn9/ztoT6X/2iuo90BUY9z8AHH8iIJOKm9kBt
	b3skoRDLOyAT55DwsHgp7clH0cB9pnO/cQZVwAJBFD3/UwjXbdW9KCS3NQnGKsa4nTLkRO46tGg
	mIR2k5O+/oZVqI3dYCmD2Mi4a
X-Received: by 2002:a05:620a:1992:b0:8b3:14dc:4821 with SMTP id af79cd13be357-8b5e535ddedmr199928685a.3.1764759913790;
        Wed, 03 Dec 2025 03:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP7UTYPI4uM8hl2T0zpyn953VeLitq0+SJ1TZI0OWnnywh4vDi4wppwYKVpl7Kowmqks+WbQ==
X-Received: by 2002:a05:620a:1992:b0:8b3:14dc:4821 with SMTP id af79cd13be357-8b5e535ddedmr199923685a.3.1764759913285;
        Wed, 03 Dec 2025 03:05:13 -0800 (PST)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4792a79dd0esm42285525e9.4.2025.12.03.03.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:05:12 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Punit Agrawal <punit.agrawal@oss.qualcomm.com>, jassisinghbrar@gmail.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jamie Iles <jamie.iles@oss.qualcomm.com>
Subject: Re: [PATCH] mailbox: pcc: don't zero error register
In-Reply-To: <20251127-cherubic-chicken-of-honeydew-075eac@sudeepholla>
	(Sudeep Holla's message of "Thu, 27 Nov 2025 14:37:45 +0000")
References: <20251105144229.467089-1-punit.agrawal@oss.qualcomm.com>
	<20251127-cherubic-chicken-of-honeydew-075eac@sudeepholla>
Date: Wed, 03 Dec 2025 11:05:12 +0000
Message-ID: <871plbn7vb.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AidoWOdQTNqK0TIUjUKH-X0H_prhKL9j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA4NyBTYWx0ZWRfX0ELLsFHl8Ohf
 eC7W8NgSgXNZosJFYx2CXmD8/fnQqBG58h/7NxCy8zYhWgxsBYxtHRICmz2Y56E/vnoseTTM6Ho
 GjC7Y58lUcP08x2QjhMdp7y+CkosO3I20A5pX3SJLOkzlAq/I4hPr9wcxUKzk8mjI2+rADLEZN2
 ZUeAL5LRbb9TPC00vTrPseqZdA8lDXqG7lPErTez4CblzO3AfxShKgHJFDPXoH8k73JgF6K9Y8x
 5IBIXkt5EDXLP53VL5PxzZ2shLUsn5VbONTj/1/bR8jfPbiqMYmUhaIguBAI0UL1sviI0bwdzeF
 5F+5NuhnpLY+0+ByErl6OUJJN8EJMler3P3nya1N3PKeIqmjIskW/Mcwua5rV9icHxr0QmxnC/Z
 vVIPZsXMh3dDU4edLKpnozCc9TnOFw==
X-Proofpoint-GUID: AidoWOdQTNqK0TIUjUKH-X0H_prhKL9j
X-Authority-Analysis: v=2.4 cv=V5lwEOni c=1 sm=1 tr=0 ts=6930196a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8
 a=qiwrPN6s67ThHlttQ34A:9 a=bTQJ7kPSJx9SKPbeHEYW:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030087

Sudeep Holla <sudeep.holla@arm.com> writes:

> On Wed, Nov 05, 2025 at 02:42:29PM +0000, Punit Agrawal wrote:
>> From: Jamie Iles <jamie.iles@oss.qualcomm.com>
>> 
>> The error status mask for a type 3/4 subspace is used for reading the
>> error status, and the bitwise inverse is used for clearing the error
>> with the intent being to preserve any of the non-error bits.  However,
>> we were previously applying the mask to extract the status and then
>> applying the inverse to the result which ended up clearing all bits.
>> 
>> Instead, store the inverse mask in the preserve mask and then use that
>> on the original value read from the error status so that only the error
>> is cleared.
>> 
>> Fixes: c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)")
>
> Good catch!
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks! It looks like Jassi picked up the patch as a fix for v6.18.

