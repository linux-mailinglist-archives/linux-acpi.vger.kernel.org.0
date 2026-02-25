Return-Path: <linux-acpi+bounces-21149-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIt/CtzLnmm0XQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21149-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 11:15:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE9F1959F7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 11:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7228F305F664
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 10:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023126560A;
	Wed, 25 Feb 2026 10:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pb9Dig/0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iwk13fPm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE933242D8
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014359; cv=none; b=Ly3fpZ+g+Am7eUZZoFD1u2vbLcT3pudCx1AEwJK3+/TQkBilZGpftdkXxV/aSZLix3v3s4iAUMRtWWN8T7jylKoBmIMdE9MuEjVoU9k5ET7WUnux2zxaRdqbVDXV2042mn3pOM1ZkltY+CyY38txWG22+6XnR96dkaUGgeMqrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014359; c=relaxed/simple;
	bh=Y22JRh9xvQfJncGH7gL+X+J/7Dt0gtPhEvqzsi3dp5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aB/8uUesUIJiMYwP10jcp/a2OMNY5fanExsFCYCvR1viqxHY9Q0e4/b2nWJWT2hyY7COdK2LwjxLTNSLs1WmMA21owRVs3s9sTR5AcyIusjUxSAS3ij66WMphzzBF7gEd8ie3rrbrCc5EnIGSNPjsLiw3jhrSsIkCupWjMRLPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pb9Dig/0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iwk13fPm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P9ScSj1087941
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 10:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sZiX6+x00Prlmosf5CSqBN
	8ltuHXD+PUom5YlTd56Cw=; b=Pb9Dig/0Rl1g0zOx+eNcao7++MrN2j9aGpqt96
	mwZP3zNonSLuwgxJy2RTVqwtckwMNZqjqpsDMgPMNtUZF9w7WJW94TkOVizP/3gu
	e/5tXQN7OHVbw6j5sJtj2rbUtGwZaUTb4ksUtGu8K62vpsqLZ9ELoRFT18FK/WPV
	qKRqX+zqL4m9KbbR383cnFTK5BlP9FrGY5KwFEvZmnVDM/e5GirgE0OWTxoSt2/C
	vHbqFHCZnJzNPStRpZYEuXwoz8FeY2zzYZciXdVOdKQ3v8zzM50nGnpoOYrHGBeb
	oPXBjmHgB3RhmjGev+09T9gHlQ76JTVJoNx/RqRWe4ZDai/Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4chh472k5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 10:12:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb4a241582so4981190485a.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 02:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772014357; x=1772619157; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZiX6+x00Prlmosf5CSqBN8ltuHXD+PUom5YlTd56Cw=;
        b=Iwk13fPm9WCUXOkUc6Kq/HOu5LizB/E7ZCE3DNDxXZVxwrG8AMXoQ6W0eU27tx4MDR
         rKlp0bHvKXIxj0BjF7tr/6KU7wK04QogWlHLe0Zh73AEMKoTxM2XcIDrHzc9hCgfmmsh
         qzZq0mSoK73VQ39ODj0Ae7GnoFDtSGk2RHH69MabJIhb9rT+dk4ACBl3lnnDGi54qHDD
         1pNW/3ctakKMyYvYKL4Kx30MUdwc20UJETTDDGWDcdXbZ0kreQcnCyGRMz08DXijQOU2
         9a7hbB7QW+UX+TXx7BpF/xEv7O0JjmgfPgSRMqZ3X3b5At4XOfYXs8I9fypeN5PGaZjI
         yaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014357; x=1772619157;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZiX6+x00Prlmosf5CSqBN8ltuHXD+PUom5YlTd56Cw=;
        b=eyrIKDA/TEAVgOW2sW5H4+G3wDLTdtiWlteWdW82oVmBDElLua7HKpOZwNXLeiUnFQ
         vrQknGlVWcgsYFgpNYuFP1KC/1pIIZ5J5uPdH3he1vl5qFqydxbxpd945W8xfmouqD1S
         Vuc+MjlqXHNUCBALWqtI+cWZk+XYmb7RgMgO1bKw6DBdKh6b+vm6PidbfDh3IZXw8o/q
         g9NsBLUKe5PHY0CpMQD96QX9euTOEqvotL8BBzLOFFrrE2WxVti9nm5PK1zDG9HfogJR
         8zXNdv/3tChpVksZhkebRqzmd0aNAXi1oWamKwJy3BgBKXqxNej9NRZRFWDxxE5LHJQS
         3vcg==
X-Forwarded-Encrypted: i=1; AJvYcCW/BmHo0oaO/HO/d/lVq1oruKb2+C2+GlmdzS6WFtT6tjV40bK9blYCoQEyhrCgKcqRqhS/FnkV6/QN@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEAoiD8OeVc0kLjs5AlxO+gZCKXCjc7cmKF3Bp5a8KGRupd6U
	f+VTB+AbxGP2OxQS4X1nHaOxXy7egvWn/P8x7idNHAI2wv2m0EX+hl6u6izwbRH2XJG7NwhQcym
	rfnPNF0+53s/O/hcuHPLADi21+XpYlgd+oh8vOPYUxTsWoVtzn8Gw6n4ZXGp1lY97
X-Gm-Gg: ATEYQzxIiSpHxVhu/oLD4kGXmV7SrRgrwKdCTYkVpB30rmkoX57kxIOWgt0WNtdkA7n
	/re8bLFxub7KzPY+zqs51smPr1BXeAaFxcNnFVbTxXBz0eS3rN3yTk30oSzUw01ytR16JQtecio
	D4XRuwTSs6jBU8vZof0Zqj7ScdlFzgC/sdMU9f68FgsvONaQ1vVoFFSmJWHoWPM6suC+Rac+qT9
	n9iiyb/2i+I4I2B96Ur0przy3n4yqofzMHC8BOm93tkis1+uaICSmW6mzKhw2n4LrcSBPSgLmOk
	OB8tfmM7O59Kcfx03YvCFP719soZ+0f9mR51YIxQYe8Yc2/T379BvD9Dbf8vJ8UfluxUXd+RS6X
	H/vn8/BGip823v1fL9lRdMm0C2VW5Susfx7rg0rhY99X9wxnObns=
X-Received: by 2002:a05:620a:44c3:b0:8cb:4543:c5a8 with SMTP id af79cd13be357-8cb8c9fad83mr1971175885a.21.1772014356495;
        Wed, 25 Feb 2026 02:12:36 -0800 (PST)
X-Received: by 2002:a05:620a:44c3:b0:8cb:4543:c5a8 with SMTP id af79cd13be357-8cb8c9fad83mr1971172885a.21.1772014355971;
        Wed, 25 Feb 2026 02:12:35 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:44ca:6a2e:7fc:1024])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d5463dsm30382107f8f.34.2026.02.25.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:12:35 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 25 Feb 2026 11:12:25 +0100
Subject: [PATCH v3] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAnLnmkC/43NQQ7CIBAF0KsY1tIARWpdeQ/jgg5TS2JBoaJN0
 7tLu3JhoptJ/uTn/YlEDBYjOWwmEjDZaL3LodxuCHTaXZBakzMRTCgmeE1NLgHSXg/Q0YjgndF
 hpO3TeYNUAnBVIsgKkWTjFrC1r9U/nXPubBx8GNe5xJfvv3LilFGtJO6NrHaygaOPsbg/9BV83
 xf5kGUgiQ9UlL9QkdFaKWAMakRsvqDzPL8B7tKUHiYBAAA=
X-Change-ID: 20260219-device-match-secondary-fwnode-4cc163ec47ee
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, brgl@kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2381;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Y22JRh9xvQfJncGH7gL+X+J/7Dt0gtPhEvqzsi3dp5c=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnssO1FWU86yfB6AvLyJgHK+Yze00jlHC3FlRh
 WgPHa+9Oi+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZ7LDgAKCRAFnS7L/zaE
 w5lvD/9yAI5DHGZ/FJImETfgbSKTxLD3sxZaQ1Oc2FzDPzkUpOvD8pQNgFoIegRVODiLCMMWJOE
 0Ohz/IYd6IlVs6yAM1DUxRWJN5IyLghlqlFGspHTdAIKTPYHMooT1TKLGQ4Q+T+XM2lDyaWisij
 xOvbyjuYZBEf//oMlVysPN2JfhOO094nevRGtt9CmYsmzKrg15Ua12xcuMFNzXbuVmPqdDDfh4f
 fro2wxPaktgRmQQtIORDr5bquasCx9ZSIp1Va6CJFmXkngp616A7Bqv+FeNRO3GSK1yx7ZSRFN9
 5RdgTF8+AuVUTsO8kPQUvOwBgY4PdXCnkqzln/3qbWyB3Cm8472KGzW6Tpelp3In2jghXxAjaQt
 HrC8N7dM3r3repoLQpcHpXByVlwFXKDwMiYXO3k+3g8Up1Dpgz/2UyEt5hkkVFJyp31LjjaoPkR
 GvoJZt0ldhXrocSLN67fC1D1LtyfFZr5RWunoi2+gZXIGe9BcSBDbpGM6Of/htih1/3W8owsD1G
 eFhywPLvub7LFMwoPL/FBnaT4gsVcPYF2WFpolGzUjMfu23V0J8E42nLGoCj2HEEuxOiUNcVDlP
 JOAwbsYjkQi1a8YBcgUj1Gtrt3YeJvhsDmj4xHioybF7cFIMMJOp3E/sZ97TaGK+XTGaux9UIZs
 rl1iAEdc/hbcWxw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: gfNQ_KMK3Pj7r-ZYlE1DEYi-mARZnLHj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA5OSBTYWx0ZWRfX5a6EEDVOmeO/
 olEA7BtAqLK3Ik5CiecUgXqA2nayek8mDZZz3MY01NYN1YHkAgHWjZ2B2Lxh8YCG2xdtpvxNzkd
 sCUo/5KQHh22/oaDpzPxJRjDSrdSrQ/uW3KtayZ17d6KwNxmpkGirzOFsLgy8HbfDcTlS7ERuxy
 dwlvz0Djxr7JMXXYxO5lTHdJTGp9hEagmDD1nrmLtObSTaV2NVNLgVxLazeaQ8vWbUgmhB4qxJ/
 TyeGsEaVV6iRlG4ufzbVvRId87VMLNEHPJw3IVhrseE8spo6608uh8siBRvpUjOgCHs9GrmhFSy
 1domRmYPhx37OuJFBRKmwWz0uWlaJFPk4EKI81tkqe4y225bgY8SgaIft434Kxvl8ypvrIo4CjW
 bO//bYt8vAinrPz2AGiWSkLZ5LSbxYRygTIM5ymOVUrmCBJcKUeF7c1KAcJouI5OouffSfht/SZ
 Yu6g5uY/r0C05kP0Kgw==
X-Authority-Analysis: v=2.4 cv=fvDRpV4f c=1 sm=1 tr=0 ts=699ecb15 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=GosmCm27k2yXtJg_9XwA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: gfNQ_KMK3Pj7r-ZYlE1DEYi-mARZnLHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602250099
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21149-lists,linux-acpi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,msgid.link:url];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7FE9F1959F7
X-Rspamd-Action: no action

In GPIOLIB, during fwnode lookup, after having resolved the consumer's
reference to a specific fwnode, we only match it against the primary
node of the controllers. Let's extend that to also the secondary node by
reworking gpio_chip_match_by_fwnode()

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Link: https://lore.kernel.org/all/aZUIFiOYt6GOlDQx@google.com/
---
Changes in v3:
- Remove the controversial patch 1/2 in favor of hand-coding its
  functionality in patch 2/2
- Link to v2: https://patch.msgid.link/20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com

Changes in v2:
- Fold the code initially put into driver code into GPIOLIB as advised
  by Rafael
- Rework the logic as suggested by Andy
- To that end: make fwnode_is_primary() public
- Link to v1: https://patch.msgid.link/20260219-device-match-secondary-fwnode-v1-0-a64e8d4754bc@oss.qualcomm.com
---
 drivers/gpio/gpiolib.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..0182603de368f2125baf174fcf5f1e893917c154 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fwnode.h>
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -1395,7 +1396,16 @@ EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
 
 static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwnode)
 {
-	return device_match_fwnode(&gc->gpiodev->dev, fwnode);
+	struct device *dev = &gc->gpiodev->dev;
+	struct fwnode_handle *node = dev_fwnode(dev);
+
+	if (IS_ERR(fwnode))
+		return 0;
+
+	if (device_match_fwnode(dev, fwnode))
+		return 1;
+
+	return node && !IS_ERR(node->secondary) && node->secondary == fwnode;
 }
 
 /**

---
base-commit: 50f68cc7be0a2cbf54d8f6aaf17df32fb01acc3f
change-id: 20260219-device-match-secondary-fwnode-4cc163ec47ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


