Return-Path: <linux-acpi+bounces-21061-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FoxHjh2nGmwHwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21061-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:46:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE05178FAD
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C479309A710
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3069E2F1FE3;
	Mon, 23 Feb 2026 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z6LzZF/n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NNIcIl6X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D42F1FEF
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861283; cv=none; b=N7mtj/FY4MuCeaTq1Lfo/XRr1aiaRARMt0VpPDi0URmlw2Nx2kZe2sr6nx40MSF9oo40NTCKbYqJ6mTRUiZFOVbYXXUrBOZVH4UCUgHTRGuq7Ttg1HD+YJip2bmemMgVrZ2fPP/I7WRym0NxZmuDYmwI3jSAKD2i6rK5noJJb30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861283; c=relaxed/simple;
	bh=/fSxe+n1OZ1v+6Tgy1mZCXlwoph1Zflj1uGrZV7rApM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E5ySqEkIKjogUJ3GHV/RN3ZWaj1YUyuI1CaKpbA5chyMAZDsRRJ3k6TzjEito9P2Xd60rlJCqsE+4GvuiGdgG/Op2gTXSLcJNnj/FaPlh+AcK1SGfheJt1QcF4SsvaykPNOLkM7mM4hvQvP2biMHKR84G8eXwt5nqREOzYqVKPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z6LzZF/n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NNIcIl6X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NDsiUN186123
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=O/YxMSsvmQ9zPmYtsY4Ckd
	pS8mcH8SzQIlIHcTMTkKE=; b=Z6LzZF/nXGRvm2/j4yDunWVwflB6jHzroYR4e6
	REdAzU3V6wMp5/9hFo530v0AN/hTiotMhKiKwFcE7cR9xlbfPGS3G0AxjhokdTlF
	W/1jwqODNhO4x5nwJZI58IZyC3H4h+TI/uy47TwT6/oGejyajl4LoJq71TdYZ2zH
	jsWririUNc0pRq+W5FvSjoqy/5B64xXCmkANsmDZ7aEN18J2nLmaG471R0SUYZGH
	H7c3eNGeaS0K3zNDlh+cmbd2O9/V157CVPzCp+lFs+XN1uuU2Sett1vxrk0j09MY
	GV4XHVy325BVCQ15wQ/lXZRxR4xQAS06zNEPcB6D/jrrsyaA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgr69gb4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c882774f0dso4120901885a.2
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 07:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771861280; x=1772466080; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/YxMSsvmQ9zPmYtsY4CkdpS8mcH8SzQIlIHcTMTkKE=;
        b=NNIcIl6XhFsDYSXMzxEApq+unkK5vTzFP17699hApsiRl8uNWaFCKwhXqe97L6W8oA
         YxjybdMHyhkhII+xLm/wZEgVjlWW54mwF4Yubrfw/1hQ/16aBmDC+x9aY8KncjCELtuz
         XvKJOmLjCfDAynV+/xHG+W+tXhurN+mJxuH2wBDFjAQupDOOIKwDD40jmjGeVnMoDqpT
         ijLBvTzm2iL06IJXIxvVp8MC0XlIyv4kQyBQP3hAMBbh64OMA9B9zK31zIoGun9qQfOj
         /MBqsD8kseHkGbLBc+vMlhPJgqnSpQHGEDKQSAzlZIFVEkJngLE1fQBNPJ+NWvil3URb
         lFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861280; x=1772466080;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/YxMSsvmQ9zPmYtsY4CkdpS8mcH8SzQIlIHcTMTkKE=;
        b=Djlsly/N0ma57NjtrCRjj97Zj1Ql5ayJOM+1x/Lo+j72n6ERyLBfgdWEh2+YglfkhD
         894cGGXDQstkixYgIZqmaZGrhAo6TaGUtkQsoorNMtyLLIApITfLasHHeyKuzd8lIAxK
         ykqKHwxQvUBy2pp/f1y1tfDVpcM2DgBO1NTSwg+hbgeDulVR5C3Gob38GVCM3HV8iac3
         sMQegpl4V9r9mtL2ZydNZDJDEiA9r7eKQvS9468fyRcJoaYgGYkeh29wuh2metBavarG
         yjMBBHPWUfFujioZvHSvurtNczhEbGj9gr8oCg/jRWmlwtHyt5RnBt607vsagaEsC9zP
         9cCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsENirIJEpHKIYoZhQGSazdALHIGPK7uIvmuwYTm02dn+lYaSWASie+GXQwIax7UF3jZr7GB9Lu/61@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vFx/C18dzeJVdOAqajvB85bXoYuOsx+JLeWqEUZyp2RBMTBd
	qtl04jWat928gRuQCBDpjyzfgLSkjku6okkY5p2kRDpytVJlm+0yNDpuqR61SEj9LQSOH0eXnW7
	iUyDgL4KmHXVOoLEI/tHKckyzeaiEEzaMB242qlTJqLV0hdU21PpquHCg91s7h0I8
X-Gm-Gg: AZuq6aIEEmkDPkqlH0lOY4Gwt0jhQwXfKMeEcyPP8hgvNC6nNfirma7AeRegIDDpDOe
	VQSbG9KbpSIBT/oMr6EKwMuzHiYH/JlzQSIrC8LmU7hMDleWESHkGySUHw/oXBkPZFbDoIRwJfM
	q8q2vfEzhuNSlzOFbfCSAhC1JdPVrJ9ZcIqTHHm9sv+8I6Z36C3NIRsoP+9aqYhKss3+zSj5GgS
	QLS3O720LAB4F1ugSSYoAOfFOjS83n+AiZnIBNCBzzYLHnkQf7bVTOzGh357zru2URgPpHvbrmO
	WzBSxXb9PD/DqweUEQv8Hdm+a7UdD3HCOZVzMaAsWBw5Jv686eHh4dZffv1Ay42XI7Pv0lzXoRd
	nLglbwnuj0GmrzqOaBOUSH+Qj5o3B1jBJ6mtMuFaYpIiCL18fEzgM
X-Received: by 2002:a05:620a:489b:b0:8cb:68ed:cc28 with SMTP id af79cd13be357-8cb8c9d1c8bmr1041226485a.11.1771861280167;
        Mon, 23 Feb 2026 07:41:20 -0800 (PST)
X-Received: by 2002:a05:620a:489b:b0:8cb:68ed:cc28 with SMTP id af79cd13be357-8cb8c9d1c8bmr1041222485a.11.1771861279696;
        Mon, 23 Feb 2026 07:41:19 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fa4:55d7:7aa4:50d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3d88sm295266755e9.3.2026.02.23.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:41:19 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/2] driver core: provide and use
 device_match_fwnode_ext()
Date: Mon, 23 Feb 2026 16:40:51 +0100
Message-Id: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAR1nGkC/42NQQ6CMBBFr2Jm7RBaK6gr72FY1OkgTaTVDqKEc
 HcrJ3Dzk/fz8/4MwsmzwGkzQ+LRi48hg95ugDobbozeZQZd6qrU6oguj4ixtwN1KEwxOJsmbN8
 hOkZDpKodk6mZITseiVv/Wf2XJnPnZYhpWu9G9Wv/NY8KS7SV4YMz9d5c6RxFiufL3in2fZEDm
 mVZvkG5vFfRAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/fSxe+n1OZ1v+6Tgy1mZCXlwoph1Zflj1uGrZV7rApM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnHUHRveWKuWKDp0sn+82PftVjhn17Y1Kr2xei
 sm9M88c85aJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZx1BwAKCRAFnS7L/zaE
 w80HD/9+l4JCPtjD6kvdPPLGWbQY5gqLHaSsauSviTdriVGGwUJEFye5fyueGABNTMDI9y3VCDf
 SR2huER91R0dHTpPBvt8uU7AG+U1k/JkCeegntxhzN2f98qDNxYFSrBQrkpUDi0xqFWyxG1/HdO
 eTqrTb7FdALrXWMiP8IOvNM3P+DjOaSSRMqIvfRArojKmAVKZzGcTczTvu17PF1PkZMS3HNntnC
 fVwjzJ1u4dAT8dl52fpeAVb1zhBN1IpgyO2A0kA63YLBQ65fFieDHy9x84FJ60cE8wgi2fId2lv
 2R3113pEtNqWAtu4bmR2LkF7jUP5M+/E70ztcURogimNdb0tIWZv6Z7bqSgVlC10NHhM64GjzHT
 p1Pw3QQWIx+akq1dB3KuEbhb5PmUdOwz79LOYappNfalgSz4/O8l02H4RSuiP//OTJW4kCb34so
 /A3qC3AJN8CxPTkOoGorYuutrKaFHsv25DsrAf8dA9EivVQ/gvXXlnmE3bm4Mzuimrjf7lRC+5B
 0+GcbgFgOedOssbEC3ECWTJm1EuYML0sSbjQWAmxdymScTq1snOvE+r9pXhZLNLC7iY4gRGfamv
 a7aWGQhob/vzdH8pjs7vZ6WazzICpkRCIQarlLVIBKcpOL1ndcUwrui+Hom73V98B6tvQ28+mK/
 FVlkpSzGbonNTIw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=O6A0fR9W c=1 sm=1 tr=0 ts=699c7521 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=AoYrAuEogKCLvLv1WKIA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 2G6XKfjc1ZiZbkYAzasipPdcZLh6COxL
X-Proofpoint-GUID: 2G6XKfjc1ZiZbkYAzasipPdcZLh6COxL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEzNCBTYWx0ZWRfXyQHF1bIaX08B
 IB0EiUJLdKDl7BadlDmwjpCW69tcGl6cFKuJYMvFo1efyTWXpZ4ii34VViKPs6dVrEDThH8NAL5
 qrq2AiYw6k+KYdKmemWi5eWvUiiYOm2Z9uF6YQj5bmXugSKzMu4g2wxVN/3m5xNlHN/jdzA9t3h
 wKL3kTzsgyRrRYqLfVjclLwNgDIqRz2FSwqMCpvMAh1t+BewZD4NULmIzW8El3fJagDtklU813Q
 UFdhIqVtNHIuRAF0bMsnmb/7X3jl4nboxZpocGBHACrH+aJ2Dv47lup1jiTcVCjhfoJ5CfD/Ekc
 ASUMNVdWEf5sq7ofU+kwBpHSosQylRPjkPdmafo7VRoW/hdomVpnA/vXzFaOMN7J7HI0lyO5ofw
 u7LfNK/NAY51Zt4Qia0TR87tymVpvMWm/X3A411Nbi/qIDrpMYss+SgWXNigWgtujktI5yoyzv+
 6o3zK18687rHj0S4jDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21061-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0DE05178FAD
X-Rspamd-Action: no action

In GPIOLIB, during fwnode lookup, after having resolved the consumer's
reference to a specific fwnode, we only match it against the primary
node of the controllers. Let's extend that to also the secondary node by
exposing fwnode_is_primary() to drivers and reworking
gpio_chip_match_by_fwnode().

Link: https://lore.kernel.org/all/aZUIFiOYt6GOlDQx@google.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Fold the code initially put into driver code into GPIOLIB as advised
  by Rafael
- Rework the logic as suggested by Andy
- To that end: make fwnode_is_primary() public
- Link to v1: https://patch.msgid.link/20260219-device-match-secondary-fwnode-v1-0-a64e8d4754bc@oss.qualcomm.com

---
Bartosz Golaszewski (2):
      driver core: make fwnode_is_primary() public
      gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()

 drivers/base/core.c    |  5 -----
 drivers/gpio/gpiolib.c | 12 +++++++++++-
 include/linux/fwnode.h |  5 +++++
 3 files changed, 16 insertions(+), 6 deletions(-)
---
base-commit: 50f68cc7be0a2cbf54d8f6aaf17df32fb01acc3f
change-id: 20260219-device-match-secondary-fwnode-4cc163ec47ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


