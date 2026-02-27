Return-Path: <linux-acpi+bounces-21198-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDyjCu1coWmDsQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21198-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 09:59:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8391B4D1A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 09:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE400304DE79
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E33D3484;
	Fri, 27 Feb 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R4/1+DXQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="McKsJQfF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684A2D8DAF
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772182746; cv=none; b=iiL/qOZvXrluvSflIh+VToxzxOVUI6KxuBRgVtKcQpLJ2Cb9vjXZ0jvsc3FykkPQYXJXKzFX4aQHElGTUFtbduH6xRVu6wjhxj4b4bFLzJVl29oMws6uW7pXa4bH5UBPLnVDyRgKQvNxq1xJ2aPSfjBBYNcAtkCB5ml8ej4KENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772182746; c=relaxed/simple;
	bh=fB5UjQPpD+D9qZyDCB8SYs/gFWNRAvvueceaPw1cEQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxKfGfQnyrHfAxipO/zqg3Lw+D8OrIuNnBNZeY1JJZh+Ca2ZqlHbxGd0scD6Kfa2mvOVFdGxM1gLUo8Hen/jMNWtOxFUI0973ttiMB3oM4OJkGLgxSDXbyGB9JN8UqEY28QodUhEOwyKrY8ScHjt7R8cIWn4FCQfEYtbArlCito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R4/1+DXQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=McKsJQfF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2KIfQ236930
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 08:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xa2xwKsAARO5/o99tsp0/G2WXxT4BDvg1rDv8++bkVk=; b=R4/1+DXQpBbCj2El
	llgdt2vPmQDBD8CFDy0MVKnkTd6eQXyKPPjuJVc6VvjxtX+SNfJ1XVcP96ZnlQIq
	C14W/xWsGKw1PkGbAG8UTQhqJXfuCdwWA345FOqCMniL/G0ZgxHgRWh7g7ltJ7Ot
	ouerbdN7CU70HTNcHDmT6yKgpIE9iYLS8kKU9hwoOnYI8ubZ0ZNvKrgvjy3mn2eV
	Uf7WgWvNaZx79bXOI0Hx7QYJNAwjcqsT5SBietDJzXJyahRuFdjXEUakcKDo+X0i
	sDIcqTa6/RKUILUhW93HBCN40FaiQaUrXHR2kF/uN+JHktF4fT9UZpmSF9jDA+ZJ
	fVHd+A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjx1xsud7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 08:59:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb52a9c0eeso2357576885a.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 00:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772182744; x=1772787544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xa2xwKsAARO5/o99tsp0/G2WXxT4BDvg1rDv8++bkVk=;
        b=McKsJQfFRzwdYdk0gliF5886NV0vUETR/gE7cBiksuffU92VqYlo2dmwK8fYOl+n9+
         JTe7Bg/s9KvFJ9uTxPOowG47RApoih+z+9zf4IckYS2yh/KYvsbxrlv1A+0kf7IB5nqG
         6O/eIFO0TldSE2gUt5aUQRhc0shKQICnOs6gsPQjSKbAjkxIdeRu0HYQIEEaUPnDChLc
         A5CuwFxxeLl/1Rcc7QBX/13dV3z9iONXm3xlSqej+2YGYyknZBl8N6gcu/LT92POWogk
         3RIUsesT/nw9oJIu4S4xc83zYhT9RQ9Wz+lYLG3jIG/zLcfXMEQcpXv5rnA/h7GdX7VW
         atOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772182744; x=1772787544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xa2xwKsAARO5/o99tsp0/G2WXxT4BDvg1rDv8++bkVk=;
        b=DXg3IUiNgr2cUxesJdi3ji36bLqMyjfpzb3eHgNlbQs/SGSFluO2OR07tllkxjIyt0
         zH2tdgyBJSrqj++D8wYo8zH1JfnaheaUHfAeH/9ns4hFYoZ5BhN+2nNw9Ed1HDwCiBee
         bsnt+/DQTu1UogWePrbCkUfnrZ/SajqFnYvS8gw6w33DcJNul0twQhe9zG0iRvipktU1
         PVJyHwYUJvYFunbUCL/bstMAq1ii4toBCNoLUUsCgOf1+aTS4NZPochVjooQi3TBmuMT
         6zl9kpO8kVQNiVkVz5tUfFjREWBVsCAPodhjhqYv4vBNo2V1u3z7/sqLtM7d+OoQxC5e
         DJzg==
X-Forwarded-Encrypted: i=1; AJvYcCWG4rtGoarZ/xR+HQkMeVc9xu8jItDBNrMrAEZVVOyVqSjPSyilKj6gcWJ9w1Zu0DeNXGStLT8W3jsV@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkfz0CnCacimRZz86Z3e7oFJFa0+xs2csq4+Ltk6vE30qhOIp
	nq+6mev6+Pn5AH8s+JCzYNTBuh/mVj3i7AnYcBqKO30lAE004juNN1GAoIvIPBnclvlAACWD/k8
	F2utQMpOCG3hA9Nx167tP7w0mj1R/ZHN7fJy9ft59MHsmWKl2KXU/41hc3sfkvWwB
X-Gm-Gg: ATEYQzz/kcGrKm8fI9iYSggNFv+46dPVJm8MJG2KurNX/dmW9gHYg4fvxey6vsttEEe
	16+ra3FI4jOVhtmEj3jAi3OrBw3m6LNUAwUT1eC+aD9OpezJVbiibi7Nbu4SFR4q2oe4NLqqTbR
	Kr7IMxCKfygHhKxqLFEzJL7KVK8QEDZDI8mvA4Qu0uP3oiZSdBr6dF8lHR8uDU81Nj/Al4vpYxX
	8+eq5FOiKvqmv85FFfcmD3Oy86kzHARnjrGC2VtuS36Q0D2vLIQl299l9RKULvwlJeCDZEQRCa2
	onftRfhdPt1gC3ZP31MmhrDZnZRAbHgk+2qvLhbT0xrbGV4OqP1R1zOxoqpF0pjHwozzAWt7CL5
	zAOF/gmMA1pscnGqOoj1klSuSkR+WzsbCCRgpfNTII8Q1b3KYlEw=
X-Received: by 2002:a05:620a:1726:b0:8ca:2e37:ad08 with SMTP id af79cd13be357-8cbc8d9d7d0mr259514785a.34.1772182744194;
        Fri, 27 Feb 2026 00:59:04 -0800 (PST)
X-Received: by 2002:a05:620a:1726:b0:8ca:2e37:ad08 with SMTP id af79cd13be357-8cbc8d9d7d0mr259512585a.34.1772182743777;
        Fri, 27 Feb 2026 00:59:03 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8bcf:177b:d085:ed57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd702e7bsm224129855e9.5.2026.02.27.00.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:59:03 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
Date: Fri, 27 Feb 2026 09:58:57 +0100
Message-ID: <177218264423.8055.13971416115087410858.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226-device-match-secondary-fwnode-v4-1-27bd0cfbd8c6@oss.qualcomm.com>
References: <20260226-device-match-secondary-fwnode-v4-1-27bd0cfbd8c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: F11oadw18zlNxq9-qVxqRkJKff5IFqxV
X-Authority-Analysis: v=2.4 cv=Vtouwu2n c=1 sm=1 tr=0 ts=69a15cd9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=riAGlF5WBYjY1qQTpiUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA3NyBTYWx0ZWRfXwRT8dlywQwor
 yEyJPuROsg67COKmSdkXxqwCDm8I7JPPlN2DQ85nggr03IdJjjMiKkVcCcFoYwa7SDWL4cJtsi/
 73oJW0coT72l8gtUlpiVDJvRcW6gQAUpXzBgKFtm/FrKCeesn0NgkK0CoZz5xxuTTtY5PiMH5nG
 pomNwGTWoOgIUh/rSSEccALFlCEAYWzQvJlmQNnOhgGsM/euHgnMvN+DYYIgHDSQfnJU3sdfkge
 03GysLWPDxItIrYxisSDd8Qk0xZ4JwKy5xod4S6g60CgU0MyFHYG70zFWiDqK0TAD72RmjoDqkL
 C74TYmv949GERk6LZ2SQ3CiduEwEfOQyL57POauQjbWtBsDOziW9xOkQSW7JOv+ho7TM80T+TP+
 6f33msi98m/fcydus3rxy0p2ZJyqBTg2XvIkIDq6nre8X48Meq5TZ5Us7jsrbxpiHp7kcxeCCuc
 8uc7EJ7qQj6ltOXUGjg==
X-Proofpoint-GUID: F11oadw18zlNxq9-qVxqRkJKff5IFqxV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21198-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA8391B4D1A
X-Rspamd-Action: no action


On Thu, 26 Feb 2026 10:56:36 +0100, Bartosz Golaszewski wrote:
> In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> reference to a specific fwnode, we only match it against the primary
> node of the controllers. Let's extend that to also the secondary node by
> reworking gpio_chip_match_by_fwnode()
> 
> 

Applied, thanks!

[1/1] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
      https://git.kernel.org/brgl/c/eb58f2b9bb0909ebce64e1a90b21b5cc2c9f17df

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

