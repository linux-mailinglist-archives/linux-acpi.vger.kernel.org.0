Return-Path: <linux-acpi+bounces-21062-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE7kA012nGmwHwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21062-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:46:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E2A178FC4
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8644D30A02FF
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85C2F83A0;
	Mon, 23 Feb 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODaCUIbA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dEwC4Agk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798A2F619D
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861284; cv=none; b=ZuKOz3oBLSpCoXa74Mlnw3aHwxrwBQ4D+NVaC9UiAIyjq7dJAA2fMgiZtjL37UHxIXW07Pz3wXYg6Fl0mt/HPXob9SOrFz+ltri0ZIwSswG08S+ia+WJ37wZYrqasMDk6CUlj5YkplJgo4nWrXZ79Aj/60FDyBBi3QU66bctINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861284; c=relaxed/simple;
	bh=pfp8lGuppkfbsov8xZVJQOkfeWli3tXHXvnSscLckXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udjhmacYyEnh7bZFiTHxwQx++sXaX2wX64Le1guHu0Qmo7sU3dvXQhOjNkSLZG4jR3O7VncRaYeXAGiQD45XGNefDU3CBXFCFwFH/1WEUa0sLxj5tBAjHQ9L+uSoMcce2s/mZTQvX2fuuk21aQtyDft+yVavGWgsCxMr1ykeFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODaCUIbA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dEwC4Agk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NAYChx561320
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yBxCPbD7cxg6fxa066CqNg9ovVGm6N9TVUFhuUjEzv4=; b=ODaCUIbA0YH38EQa
	obov5rr+Y34iUAuJxFvzVXNokPW6AM2FvZVhMYEavFz/wj/x0T2+s7HJHvy9AT/o
	zCDnTD+yH42/hlGFOn5akOZha1qqtTj5FcTSXHF7eYRKBatYJtOUJcuobkxpkSNM
	4X4J4kUk5YQ8h6WyRhd8kEnpI8dDgv3r4ORQ8UU5cCudLT6IFMaNEDQxYk9DZakR
	2RSTBC0AIJa4F2tSuahXR4OiCdsVpTHz3Vgdfqh8kLUz++eS0GaDpZ02LxrFDxAX
	dKBi/cFdpgNDGNzDAjjp1B4jUe13VN9iVMLS8fOcMofsRw6ovg7nMzMZFCPUUCO5
	3uVnfg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8r8uxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:41:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb706313beso631923085a.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771861282; x=1772466082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBxCPbD7cxg6fxa066CqNg9ovVGm6N9TVUFhuUjEzv4=;
        b=dEwC4AgkoM3fD2NVsfon46NZh3MSI/fFl5usNWfyeIKqrM4VVqL+JZL5uCqPAW8FET
         CxbOYEkyTpJxI9gYqGmGXdke4KpbN/OwnGYjVCCRs6C+j0d3HwHFeP9DlsNpdN3rUh6r
         tbC9qExqnKrx/CSGYFaZ9hUAWeZFGMtseMvJCIPUtSRB3sZyLvIUnGfRIdsO3q6/C7ku
         +y/5paZEotwwU3RcwczotYsu+Y2xV8jKE2otoAkaTNH5hrzZifuycfbvyGyFKAr8sy4W
         WCTAvV2fN5B6zF5jutzY3RuX7YNbk/zQw+SAK54DxzSa6+bK1UVJuKAzeAb9n5ePOWG8
         IFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771861282; x=1772466082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBxCPbD7cxg6fxa066CqNg9ovVGm6N9TVUFhuUjEzv4=;
        b=ShNl85mNHFZHFnjKGwqJTfxjoU/Fte3NZwSRQnKwXv/laPQWANnrgZJSLjFSJfjY8w
         O1V31ii9xMrL9zWsLUa9TdUydLvxdtbi5UKaPO01irrvg3a1TUetUpcgihvP/7t/3S/A
         rgLpHNr6KM2x5VyyuyuHOUQe2q+DmbjjhXzHurO845B/qg3MItWIWgebbUmw/FTEgIPA
         joVmUYt8fehpTNd9mNP4tL/N0bGcwrXChCZ/F+Kh5L1ljG26CuAZ6SE0GNPeR0NJSN2h
         ras1uthof3bo3q9WhdFiDx4r+gvCEtni1klMkZN6/RiIr1PJsJW6fexWG32LHYAtynOr
         tMWg==
X-Forwarded-Encrypted: i=1; AJvYcCXDI3Se6HmeCXEH0O7azp+xPrfozbaWhcJD16OWiIMvmVDWiUdnTtaS7s6Oe4VaUJNgLJONflct5QNA@vger.kernel.org
X-Gm-Message-State: AOJu0YykVvPFaiT/upxUQQVPjRyAV020tTQ2wygAGUMN2XE83Nb6NxcE
	+8iGSwbc+bTahCBde+9LawNhHvYgBc5ECGJ2uO7TEG93DXgaeSBWnh8YIRugEAZxbikxJgVY7ye
	DDgHqgwP3V4S93zJdaLgqhNPYqd52j7lkD9n70nxsXdzcWDFocQwpBIcrYn8cXIbv
X-Gm-Gg: AZuq6aLy0dC/jnYjfZIY5FbhgTSf9a6FyqafLIazpqyfik1USCu8y/ttrati6CkimgV
	ujZi+b2LOpFG3Vg3zFG2QllscSpagRM+0BgOQLHOAEuNzOOWa096L/PpYUaQg4sgkEN29nrm0UZ
	QMDBlPGqEsj2k5oT5en/hyMWkjxyCFnaO+sZZBpBw0iX5CoNwc2n9eu1H2gMHhhuv2wWO0metTc
	OLjIj9zXwUyA7mdv99B7S4ng+POA9GisSCy6yrQQkyvvID4HRz3h2N7O9tI4VCk5QmjrczIxImu
	AVweRzTT5ksAF+wBIr8C+4p3V/o9vVcVomUEz06Lgjhz6UM89uanDnPF7GLApVNTKGyUc5e3Teb
	VElAIQdCtwGHjHr1nFqZ/1q3Nv1TDJFAF5dE6itnaulgUAI5ur9B3
X-Received: by 2002:a05:620a:4102:b0:8cb:3870:5c1d with SMTP id af79cd13be357-8cb8c9fe5b5mr1218900885a.27.1771861281797;
        Mon, 23 Feb 2026 07:41:21 -0800 (PST)
X-Received: by 2002:a05:620a:4102:b0:8cb:3870:5c1d with SMTP id af79cd13be357-8cb8c9fe5b5mr1218895985a.27.1771861281242;
        Mon, 23 Feb 2026 07:41:21 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:3fa4:55d7:7aa4:50d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b3d88sm295266755e9.3.2026.02.23.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 07:41:20 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 16:40:52 +0100
Subject: [PATCH v2 1/2] driver core: make fwnode_is_primary() public
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=pfp8lGuppkfbsov8xZVJQOkfeWli3tXHXvnSscLckXk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpnHUbz5fZR9VccnEPbth0krmyJnnkHE7JFHh0l
 kJ3AXKZstGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaZx1GwAKCRAFnS7L/zaE
 wxN4D/9IvnuyHM2lRNXCv7mFlZd1TpW6H2vfx7M3xyQNZpdkwvC7cIk22PEZ0ApdtcYxhkBwqAm
 WHmOFHsPC/fy7pzNdBxbvvz4wVr9vNq9t8+el1I/CheCI7eJ464fW/COL2+5N8ETubExujFukhZ
 DhZssd783JD7lSZHH1Qd0sXrNInneThxh591xIDlqvQAcwWESug1KLSYTKpbGpYGGw0feot0K1U
 C8NeZOM0rfvqcA3dKHJbg9C4kws7KQhGUW1CkrWKqmkMkUaol+2QuCmVyL47LOKoTHg5hDy031Z
 wf6Y2Xcs73RmX3fmuSkig3cnEHTgpAv5GVldMXmErDSrIhgI2yS6y5yi2eGHaupX//wkQRYp0UA
 dvGNeCHzOQcsH1ny/IcEWuDGLkt+zMv6ZJtscgXv4PS1WXHAfM2gHC4X2qqW4qHefbdQtfNVqKN
 K+LCQHXRzSkINx9/nm63Uh6y+uU7sx5Nt/+UDQbz68b30g7Mh6qKB1H2vZzh8e/RJKhOvHo+fOw
 UhOliYfCjOgHp0wYUz2RWkFTtBZ8u741VkwLQ5/YGxeqHCnORoaGMuBsl+ldNmkc7IUA0gZKhZN
 VOHM8DZ8dAliZYQR22ERy7jTlUzUm/ufJ0DQVfzjJtCTVlglpewX7G+/ZGXyvwWbWELQMMX1GZQ
 hX+QZcJrFNRUQEA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: yWu20axoAhhvjxqGZvLEUUD-rG7g_73z
X-Authority-Analysis: v=2.4 cv=V7twEOni c=1 sm=1 tr=0 ts=699c7522 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=PHKWDHO76ZnW9kbunpkA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDEzNCBTYWx0ZWRfX2V/xcA6bSPWy
 PIz9p2W9FmI+InJj8bgcnr8z5Wvg7Z9RRpDS3iNjY3Lz/duZ6LlI2IcnmIIy1dzn/3lJWiacLP/
 FJZP+ybdLM9IVzDA9WzVS602jOqylXcPk0G8qMoSHl7aFGNsiO2XrKQHhgKnL1gR20aimlelhTW
 szP787ETMdw2k2Zrncy2/ohNsbIvrYGrWD9x6gDCZSRTzlBNABkrY+JPZtU/U4zegm2Aol1BSP7
 4oF7WqenqPX0aibbEZmobMfhlcT/icTDuIXPh1VCWR5NzYxmx7yXP9vOcudK7qlt9D4BNfRXy/i
 Zg1Gyb+AZbUSmlAdsyn6zm5v0DT3RSCpoDTrNrgbyYXrZemTy/jGmUOEVh3hD9vlhfuSf+KrU26
 KOUqiHgrf7oDQLKdu/rWtE2A/B+wyRAcdXq9+G92XEo8I7YgrRWtymS9qwnHBIUlcJLp05hm7jG
 jaTYqrUHWtwlfX55I6A==
X-Proofpoint-GUID: yWu20axoAhhvjxqGZvLEUUD-rG7g_73z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21062-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 91E2A178FC4
X-Rspamd-Action: no action

Export fwnode_is_primary() in fwnode.h for use in driver code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/core.c    | 5 -----
 include/linux/fwnode.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f599a1384eec90c104601422b04dc2b4c19d4382..2e551bbe591b09c66b113b419ba63f17e8bea94a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5122,11 +5122,6 @@ int dev_warn_probe(const struct device *dev, int err, const char *fmt, ...)
 }
 EXPORT_SYMBOL_GPL(dev_warn_probe);
 
-static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
-{
-	return fwnode && !IS_ERR(fwnode->secondary);
-}
-
 /**
  * set_primary_fwnode - Change the primary firmware node of a given device.
  * @dev: Device to handle.
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 097be89487bf5c5a96f01d569c1691088db4f0ca..04db7f3ea50cceb9025c82c6449ba342d0e1b4a4 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
 bool fw_devlink_is_strict(void);
 
+static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
+{
+	return fwnode && !IS_ERR(fwnode->secondary);
+}
+
 #endif

-- 
2.47.3


