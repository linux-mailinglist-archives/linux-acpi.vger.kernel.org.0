Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5398B1CF7E
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2019 20:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfENS7H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 May 2019 14:59:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43155 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfENS7G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 14 May 2019 14:59:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so20375019wro.10;
        Tue, 14 May 2019 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=l9E2Hq9FLPs2R4k3v/109yiHwcmV7e1E97gP56BV7Ws=;
        b=mMV13v3wYp7MeJP+JJbIIY9J6fwAq5WmMBPxNmmbBlBB6Gx3ZC8fn0Cmnri+Qjcxtm
         EokZn6N8kNv7Qf7Kdul4pCvvg3/+Sp3BN6P+AAzp3cvdxVoYU8ZWsPK3kv+j55Taj7Cs
         ZV9TFVy3CQEz4mUxB4WZmjSEtsu6U7OzTfHkdk3UJB0u8YnVw+mzcHk60MM4x3bFsgHs
         ad2t43pqUV0H6qK2Y2xJlQqDlmYrGzZTLYf67VZt+4ALoQUfyWEb4/v1CkRSi1S9v+vp
         q0xFR+SeYEl5DkZqLm60J1G0AD9QhtMpQFp6xGDH2IQearc0BqsxXTbPyzB2aH5V9H7r
         VY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l9E2Hq9FLPs2R4k3v/109yiHwcmV7e1E97gP56BV7Ws=;
        b=Vt+Rcr7fGjysIF5Lr8eeFipUMGepA+IOB+ua9QExwIR6P3Q/W0uJA+L3pTVv5D5uxB
         lgNkW5kZ9zM5DTDscIBdV12SgAGAOXSSarsNECakMyoieP4W5+YvJFAs7FIMOhfqT22b
         tIeJ2XG27B/81yPWOwjIgwiphOaVfGTGQVukG4keipanbh4Fizf3M02iS2Ia5gS6IRFf
         N0Yg4IzZuRiD+kvFO7+HF2amhOcOJikmtKzqM6wKzXpnhO2dQk1Iqy35Pzvv38eCVJ+n
         nIu6z2nd91a/fCu030QygOTC+dWEtUue+TcaB3TStKmBKyjAWYPmbIWrvKQkTgbHUxq5
         88IQ==
X-Gm-Message-State: APjAAAXrFR5iNb498+L7jJapN6AFc8i5vFO9SGcP5sSbqx+pZNoHNlEV
        c0UEFDVAwktLqxnihdEHcpeqsrS41So=
X-Google-Smtp-Source: APXvYqzIpS1v0F/fkPzu9k6g5HPhj2GoIeXfiNytHKhzM2h5jQ8M+SL7ngEBeIHCh1hOz0DT6t1diw==
X-Received: by 2002:a5d:4f88:: with SMTP id d8mr4370508wru.34.1557860344753;
        Tue, 14 May 2019 11:59:04 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id a15sm23035106wru.88.2019.05.14.11.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:59:04 -0700 (PDT)
Subject: [PATCH v4 04/13] platform/x86: wmi: Add function to get _UID of WMI
 device
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <35811fe2-7aac-aa3c-46dc-2bef515b0f47@gmail.com>
Date:   Tue, 14 May 2019 20:59:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new function to acpi.h / wmi.c that returns _UID of the ACPI WMI
device. For example, it returns "ATK" for the following declaration in
DSDT:
Device (ATKD)
{
    Name (_HID, "PNP0C14" /* Windows Management Instrumentation Device */)
      // _HID: Hardware ID
    Name (_UID, "ATK")  // _UID: Unique ID
    ..

Generally, it is possible that multiple PNP0C14 ACPI devices are present in
the system as mentioned in the commit message of commit bff431e49ff5
("ACPI: WMI: Add ACPI-WMI mapping driver").

Therefore the _UID is returned for a specific ACPI device that declares the
given GUID, to which it is also mapped by other methods of wmi module.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/wmi.c | 19 +++++++++++++++++++
 include/linux/acpi.h       |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7b26b6ccf1a0..b08ffb769cbe 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -635,6 +635,25 @@ bool wmi_has_guid(const char *guid_string)
 }
 EXPORT_SYMBOL_GPL(wmi_has_guid);
 
+/**
+ * wmi_get_acpi_device_uid() - Get _UID name of ACPI device that defines GUID
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
+ *
+ * Find the _UID of ACPI device associated with this WMI GUID.
+ *
+ * Return: The ACPI _UID field value or NULL if the WMI GUID was not found
+ */
+char *wmi_get_acpi_device_uid(const char *guid_string)
+{
+	struct wmi_block *wblock = NULL;
+
+	if (!find_guid(guid_string, &wblock))
+		return NULL;
+
+	return acpi_device_uid(wblock->acpi_device);
+}
+EXPORT_SYMBOL_GPL(wmi_get_acpi_device_uid);
+
 static struct wmi_block *dev_to_wblock(struct device *dev)
 {
 	return container_of(dev, struct wmi_block, dev.dev);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d5dcebd7aad3..d31c7fd66f97 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -376,6 +376,7 @@ extern acpi_status wmi_install_notify_handler(const char *guid,
 extern acpi_status wmi_remove_notify_handler(const char *guid);
 extern acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out);
 extern bool wmi_has_guid(const char *guid);
+extern char *wmi_get_acpi_device_uid(const char *guid);
 
 #endif	/* CONFIG_ACPI_WMI */
 
-- 
2.17.1

