Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B588930E22F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 19:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhBCSO2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 13:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhBCSN0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 13:13:26 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C23C061220
        for <linux-acpi@vger.kernel.org>; Wed,  3 Feb 2021 10:12:25 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q9so145496ilo.1
        for <linux-acpi@vger.kernel.org>; Wed, 03 Feb 2021 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUxAyPrY9bzYiy2Y6nOYwDKwIFGYOoQbH3S8TsMIGGo=;
        b=LR/v+EQTUWjnJKFoLH/BjXkI1v2ATxLTA/9R548MdtOmefM0aLvLpv9/MWD9oW1GOH
         QKHPDO+ry0fgYGWTAPMeVT8xDgc/shSmWyNzLIxY3W5EHahxOmylIUosLP1esDVrOSi5
         ZEML4NYRuBEf1RSlpmX0w4jdLCcyxu2NrMaeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUxAyPrY9bzYiy2Y6nOYwDKwIFGYOoQbH3S8TsMIGGo=;
        b=UuQ7KMfBasCoTbn6VMBIFs460o3vLaRnJ7bMK7AW0v4XaUEf9C/DSV7nXteGuWKfoi
         j1T1+LUsOTjgA47w3W5oZ29J+9msAn4Qtm+PPxYavBCEA+RC7MuWyM7T0HrTloWekm1c
         dacQoznNf9He3ZBWrEYLfArTHL8pqbsZo2pXnr6DIbfcNrdNhW3uzK7piDRkZYy52+Hs
         RCSM/ZoV847uK4lKngLOGxOmPFDNyfoU36gZ6TKqbvvHOTirWxS0nVBnTq76dviLxyhE
         a49EfX5hu6dGVuFFgaGk/fbYtWoo4zNDcWVaXMKAL8K8KRgZz2prcaHm7DCm9OMTiKhB
         xaDQ==
X-Gm-Message-State: AOAM533beSq1UhQzSGPGX7tIg4nSlv/jwvc8NfMZVkbgs7F2cuJKuos6
        809heyadGwwgsZOX/Pt1GEvERw==
X-Google-Smtp-Source: ABdhPJw0eL16dUnCKGI3iOotRcsblpIUnhTWl5T5z/Kvix9OHdAsThLGIlz4f64aUNb4fUBUNPr/dw==
X-Received: by 2002:a05:6e02:1311:: with SMTP id g17mr3521304ilr.47.1612375944759;
        Wed, 03 Feb 2021 10:12:24 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h21sm399684iob.30.2021.02.03.10.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 10:12:24 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org, peterz@infradead.org,
        keescook@chromium.org, rafael@kernel.org, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 6/7] drivers/staging/rtl8188eu: convert event_seq to use seqnum_ops
Date:   Wed,  3 Feb 2021 11:12:02 -0700
Message-Id: <5bee25950b546b28e03a7c71cb494ff1b2ded083.1612314468.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1612314468.git.skhan@linuxfoundation.org>
References: <cover.1612314468.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath. Convert it to use
seqnum_ops.

event_seq atomic_t variables are atomic counters. Convert them to use
seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 23 ++++++++++++++-----
 .../staging/rtl8188eu/include/rtw_mlme_ext.h  |  3 ++-
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 8794907a39f4..2fa5a8c44d28 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -7,6 +7,7 @@
 #define _RTW_MLME_EXT_C_
 
 #include <linux/ieee80211.h>
+#include <linux/seqnum_ops.h>
 #include <asm/unaligned.h>
 
 #include <osdep_service.h>
@@ -3860,7 +3861,7 @@ static void init_mlme_ext_priv_value(struct adapter *padapter)
 		_12M_RATE_, _24M_RATE_, 0xff,
 	};
 
-	atomic_set(&pmlmeext->event_seq, 0);
+	seqnum32_init(&pmlmeext->event_seq, 0);
 	pmlmeext->mgnt_seq = 0;/* reset to zero when disconnect at client mode */
 
 	pmlmeext->cur_channel = padapter->registrypriv.channel;
@@ -4189,7 +4190,9 @@ void report_survey_event(struct adapter *padapter,
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct survey_event);
 	pc2h_evt_hdr->ID = _Survey_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	/* seq is unsigned int seq:8 */
+	pc2h_evt_hdr->seq = seqnum32_inc(&pmlmeext->event_seq);
 
 	psurvey_evt = (struct survey_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 
@@ -4239,7 +4242,9 @@ void report_surveydone_event(struct adapter *padapter)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct surveydone_event);
 	pc2h_evt_hdr->ID = _SurveyDone_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	/* seq is unsigned int seq:8 */
+	pc2h_evt_hdr->seq = seqnum32_inc(&pmlmeext->event_seq);
 
 	psurveydone_evt = (struct surveydone_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	psurveydone_evt->bss_cnt = pmlmeext->sitesurvey_res.bss_cnt;
@@ -4283,7 +4288,9 @@ void report_join_res(struct adapter *padapter, int res)
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct joinbss_event);
 	pc2h_evt_hdr->ID = _JoinBss_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	/* seq is unsigned int seq:8 */
+	pc2h_evt_hdr->seq = seqnum32_inc(&pmlmeext->event_seq);
 
 	pjoinbss_evt = (struct joinbss_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	memcpy((unsigned char *)(&pjoinbss_evt->network.network), &pmlmeinfo->network, sizeof(struct wlan_bssid_ex));
@@ -4333,7 +4340,9 @@ void report_del_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct stadel_event);
 	pc2h_evt_hdr->ID = _DelSTA_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	/* seq is unsigned int seq:8 */
+	pc2h_evt_hdr->seq = seqnum32_inc(&pmlmeext->event_seq);
 
 	pdel_sta_evt = (struct stadel_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	ether_addr_copy((unsigned char *)(&pdel_sta_evt->macaddr), MacAddr);
@@ -4386,7 +4395,9 @@ void report_add_sta_event(struct adapter *padapter, unsigned char *MacAddr,
 	pc2h_evt_hdr = (struct C2HEvent_Header *)(pevtcmd);
 	pc2h_evt_hdr->len = sizeof(struct stassoc_event);
 	pc2h_evt_hdr->ID = _AddSTA_EVT_;
-	pc2h_evt_hdr->seq = atomic_inc_return(&pmlmeext->event_seq);
+
+	/* seq is unsigned int seq:8 */
+	pc2h_evt_hdr->seq = seqnum32_inc(&pmlmeext->event_seq);
 
 	padd_sta_evt = (struct stassoc_event *)(pevtcmd + sizeof(struct C2HEvent_Header));
 	ether_addr_copy((unsigned char *)(&padd_sta_evt->macaddr), MacAddr);
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index b11a6886a083..09b7e3bb2738 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -7,6 +7,7 @@
 #ifndef __RTW_MLME_EXT_H_
 #define __RTW_MLME_EXT_H_
 
+#include <linux/seqnum_ops.h>
 #include <osdep_service.h>
 #include <drv_types.h>
 #include <wlan_bssdef.h>
@@ -393,7 +394,7 @@ struct p2p_oper_class_map {
 struct mlme_ext_priv {
 	struct adapter	*padapter;
 	u8	mlmeext_init;
-	atomic_t	event_seq;
+	struct	seqnum32 event_seq;
 	u16	mgnt_seq;
 
 	unsigned char	cur_channel;
-- 
2.27.0

