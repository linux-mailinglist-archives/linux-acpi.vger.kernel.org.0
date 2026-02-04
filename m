Return-Path: <linux-acpi+bounces-20850-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFLkA74bg2l/hwMAu9opvQ
	(envelope-from <linux-acpi+bounces-20850-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 11:13:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BF7E4525
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 11:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEE633008D62
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394C3D6677;
	Wed,  4 Feb 2026 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aOOwuMYV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G2+4yvK7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9593D666F
	for <linux-acpi@vger.kernel.org>; Wed,  4 Feb 2026 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199995; cv=none; b=fcmcTVDbI+QpLEBl3LNFvBz+Y55QYWwL46zRTuB4GLYqVKp8m5GasQiJs5S60T4JM0vX4pOJyq56RgqaIJhplX5Ddq6x/JYYQVNPK4f0uZi7HfEvVb7o6vrQnSXtOTf+K7hkcq48KIEMPQmcDWjXqz7SXDzyy0DrWqmCofsBtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199995; c=relaxed/simple;
	bh=hSr+3DkhuTBLC1ZfqOWGzt2/OnptmSjLzpO3fr14naQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3XXSul6nFoupIQqTEl2xrzc44pcBDtbSmIOI5uC5BH9f0lPRFCyMm1Hl2raD8QrM4XKcAtRkh4nwJd1c3Um/Eel6wlGYJZMya++8s+BLYMUies+bUvnsc/yDp5Axdpwi3NEYEK56wprXOWekbkWaozUJ0eha6ti5AMod6XSy7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aOOwuMYV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G2+4yvK7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6147EW29012510
	for <linux-acpi@vger.kernel.org>; Wed, 4 Feb 2026 10:13:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L/6g19zllu1CyIYxIc77Lzd8D+AGpB8pGSv9LnXDuYk=; b=aOOwuMYV/1/46lOw
	GQawbMvilp5VR/6MtoI4Wx/s321mybbUro8tybOtgBfWhRD/6GYUo5cHq4buEnAM
	gGarvBYOWsPlzewaEhvhCsM9QslWokn40VxCE9eWJ9WGDkrkDIjETfGEPtj/0wMS
	ObmFlxXuUm3RYP9Y7trlnVHtQx0G4ns4oUh02YOLtSNWNNC75y2G6rgCL1wMqBjy
	tD+m4w2JkfhTw0JWLcKjysIqf1W2zuw5B8/lzMeDYf9tvTvStLaQlCo07E2DtK7M
	KuQDTZCCrshexvheDHoOT4yE57uSG/g4QdYVPI+FtTYBkk2oqpWRjkRRuTzZ2Nur
	jk61Sg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3h07kwhy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2026 10:13:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c52f07fbd0so2943077485a.2
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2026 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770199994; x=1770804794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/6g19zllu1CyIYxIc77Lzd8D+AGpB8pGSv9LnXDuYk=;
        b=G2+4yvK76fLeruHloPrkZgEb7S9i+vbtP3N4N88XklKlhZk9FORAc9wtorfAlffnKK
         12GNo9/xRtQ3CYFzNgdWK+jTyGnsqCK/4Fy+MhePyntAMWTZ35hq5i6KWc6Ndw4oj12y
         HyXxJU2U4u3063mXodr86vF4rJK8Ozxlf2bGS4j873BXSotvA3O9dkmljlQwXLJjFjK6
         xF/a3u+jd/woqcZcEx/fYNVVZpqnA8yW7llQ3WkVHlNYwJj4ngdLEV4a1Uzsjn843H3+
         uZLLjaIcnPIBJZX5pYqI5xZuhO1TzU5kT4CxDcUEmL7IAcV0eYKICmJ9zeBBDk6MWc0y
         p9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770199994; x=1770804794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/6g19zllu1CyIYxIc77Lzd8D+AGpB8pGSv9LnXDuYk=;
        b=JV87yeOSGcdn44z66Iz94fb52ATliMiqGwqtevcM2zSipS0yamDoPJ2hidGHazM4/n
         WcoEU6xE3iK/jGs3TfTOAEM9LFnMCkW/PuRGwiPdXACk/X0V6nPcWZUViiUi6l3KhxRn
         Tu08Kph/URcUFhQRgezELDSgIGhuaNmU27QAhgUpA/LGKvJ/JzNAIJVVyPUwV+/bH1KK
         wZrzc//0cqw1g9lQmR5TqWFlnimAwYnvYICXb0xD8efFWXKiAw+3OZNDMm90KhxCPNfa
         m14VTN90BWDmBCIxJ2rW5ueBr5jcmeSIePelkD2KCBzcGflYi1eruk7Av+QlggBha4IY
         HQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyUBNugNAvZf7VsGeGeOc0KmN6rriMheEBjL0fIwLt7ertd26J3CjzgQUyK4rlh63garzOpT6vVv7o@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XY4gXQXkeBBbz+ohLpo7oGXeO2MKlSlcEbaZUXF8vA0QJjhS
	wAGjO0cmyXK34z4wjnEGz8TYZ6oUPmK7uUjIg2lc4W9esB5cEpTGqsYV36JK6Pk6D+DTp09hhM9
	u1b81Xg244zWqgPnKGA4Dxx3xrNIJImiisWMtrmqQLVw5DwUxZB3FH/bw6gGkzPIdfnmbUWOV
X-Gm-Gg: AZuq6aLXesnfBQlWaESmeHjklDODim0gM/5ankyV315lvOF1QtrOIiSZsRxRzesWRJg
	4geMKN4GQwd4ltSLaDIVeXer82QcKfIivgxS/ckLhRkSpkd7PF/KoictpGPidwg6m9paOIWvaey
	NkMnvaMZds4EdpPEtIl3OOw3lNlE6+IlwTikEJ1PerCOOtCNazOKPMrjuLGl65rfZEzG7L5nCUK
	8ri9FM0A/u/+qfLgsRrP/ln3DC9fgF/tZjJQUqkhaj54AdIitydIH8VRNe89d5rOwjvTLj+Zu3C
	B2kXddkV8PRp2NrzGjYDqAQhbVMz9AxgFG1hWHWSKjyJlR9qox5TlaMZ6fRTn/FO/6G/iPk+1kZ
	dsEsrMZh3XDWQK1BWF8wHGcc42QE2sQngytK7
X-Received: by 2002:a05:620a:4506:b0:8bb:1a5b:5a47 with SMTP id af79cd13be357-8ca2f807305mr315918685a.17.1770199993744;
        Wed, 04 Feb 2026 02:13:13 -0800 (PST)
X-Received: by 2002:a05:620a:4506:b0:8bb:1a5b:5a47 with SMTP id af79cd13be357-8ca2f807305mr315915785a.17.1770199993209;
        Wed, 04 Feb 2026 02:13:13 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:fcc2:cae:2a7f:59c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f25dsm5575037f8f.29.2026.02.04.02.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:13:12 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: linux-gpio@vger.kernel.org, Alban Bedel <alban.bedel@lht.dlh.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Mika Westerberg <westeri@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Fix gpio count with string references
Date: Wed,  4 Feb 2026 11:13:11 +0100
Message-ID: <177019998811.9840.13337538910664862668.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129145944.3372777-1-alban.bedel@lht.dlh.de>
References: <20260129145944.3372777-1-alban.bedel@lht.dlh.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA3NyBTYWx0ZWRfX5Ok6RZP7hWNC
 KJN6YBVgYg8QFHbZiXnNKQ+pLAJrKcm6mSv5jgSHP3n/tR/qXAq8hOceOJF3Z36mk7XTf3Vl+1A
 2sRtH0IrJNfIYpl6iFX5JG6onK/UqEc2gdoKhjpiRPPBDn7C2kd8Z6/HuRORuuHkq/UtpBaQnyX
 OkvXeJ2bvDgFCCpg3er2bMkJ0QRkxbUZcwLmd4NEbsHaRNArlluf61niOXjv7uvHWVQYBdWj18o
 f6A4EkdnRpyR0quOZmaLkX40LjLDcg2R+JlepX3AJKiyVyC29vvGRayqmkB0hXlV6nSP8h0KrtB
 RndJbTShRel4drSQJBkXyAe3ZdEyCggre4pzWYC91H17YffC/2BjL64sTS3mjj2N2IMcVXw+W2z
 ySJKVGGYCu9gFkzgUn9jyh8frXWlRRPBUzRo5nmlzLmVibRnyVSSPyrjKwIIg4BFNpm2VlV6vNE
 pqB0z0lVDj5YI5fBjYg==
X-Authority-Analysis: v=2.4 cv=CMknnBrD c=1 sm=1 tr=0 ts=69831bba cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NvIUnWIGczD_N1uvXP4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Kf76ICjsXwIuMy37ViA8zqE26jF6hcnL
X-Proofpoint-GUID: Kf76ICjsXwIuMy37ViA8zqE26jF6hcnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20850-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A4BF7E4525
X-Rspamd-Action: no action


On Thu, 29 Jan 2026 15:59:44 +0100, Alban Bedel wrote:
> Since commit 9880702d123f2 ("ACPI: property: Support using strings in
> reference properties") it is possible to use strings instead of local
> references. This work fine with single GPIO but not with arrays as
> acpi_gpio_package_count() didn't handle this case. Update it to handle
> strings like local references to cover this case as well.
> 
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Fix gpio count with string references
      https://git.kernel.org/brgl/c/c62e0658d458d8f100445445c3ddb106f3824a45

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

