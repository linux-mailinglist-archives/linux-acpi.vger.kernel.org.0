Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC9CE83C
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2019 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfJGPsj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Oct 2019 11:48:39 -0400
Received: from mx-out.tlen.pl ([193.222.135.148]:14155 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbfJGPsj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Oct 2019 11:48:39 -0400
Received: (wp-smtpd smtp.tlen.pl 22843 invoked from network); 7 Oct 2019 17:48:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1570463313; bh=o3vwmCdN0pZu9+76pn352/XMaPJsw346ZXswcDLn5cw=;
          h=From:To:Cc:Subject;
          b=F0toWhB4rIsfG8DA2wqCZocPDuEqZ/8G/J+/kZJw3fKahu8S03HV4DZ2l3CyNZOdW
           WUFLNhvvt9ZsKqLLjO8gq88SupZciBYcPEf1cSAKoyliTEnlEekFFSOyBr/KOjqz85
           m6NJCKgogX/7bcaI/200TtJ2cH6wMdMDvT10tcLc=
Received: from public-gprs408404.centertel.pl (HELO localhost.localdomain) (cosiekvfj@o2.pl@[37.47.226.149])
          (envelope-sender <cosiekvfj@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rui.zhang@intel.com>; 7 Oct 2019 17:48:33 +0200
From:   =?UTF-8?q?Kacper=20Piwi=C5=84ski?= <cosiekvfj@o2.pl>
To:     rui.zhang@intel.com, rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Kacper=20Piwi=C5=84ski?= <cosiekvfj@o2.pl>
Subject: [PATCH] ACPI: acpi_video: update doc for acpi_video_bus_DOS
Date:   Mon,  7 Oct 2019 17:48:18 +0200
Message-Id: <20191007154818.7416-1-cosiekvfj@o2.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: o2.pl)                                      
X-WP-MailID: cc6d1bf059268021cbf44213ee77d9e7
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [0SLx]                               
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

commit:
efaa14c

"Starting from win8, MS backlight control driver will set bit 2 of the
parameter of control method _DOS, to inform firmware it should not
perform any automatic brightness changes. This mostly affects hotkey
notification deliver - if we do not set this bit, on hotkey press,
firmware may choose to adjust brightness level instead of sending out
notification and doing nothing."

win7:
https://download.microsoft.com/download/9/c/5/9c5b2167-8017-4bae-9fde-d599bac8184a/BrightnessCtrl.docx

"To avoid problems that might occur if both the system firmware and
the monitor driver control the brightness of the display, the display
miniport driver should set bit 2 of the argument to the _DOS method.
Setting this bit notifies the system firmware that it should not
perform any automatic display brightness changes. The WDDM
driver must set this particular bit because it controls the _DOS
method. The other bits in the _DOS method control the behavior of
the firmware in response to the display switch hot keys."

win8:
http://read.pudn.com/downloads193/doc/907411/Brightness.doc

Signed-off-by: Kacper Piwiński <cosiekvfj@o2.pl>
---
 drivers/acpi/acpi_video.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 4f325e47519f..2f380e7381d6 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -699,9 +699,13 @@ acpi_video_device_EDID(struct acpi_video_device *device,
  *			event notify code.
  *	lcd_flag	:
  *		0.	The system BIOS should automatically control the brightness level
- *			of the LCD when the power changes from AC to DC
+ *			of the LCD when:
+ *			- the power changes from AC to DC (ACPI appendix B)
+ *			- a brightness hotkey gets pressed (implied by Win7/8 backlight docs)
  *		1.	The system BIOS should NOT automatically control the brightness
- *			level of the LCD when the power changes from AC to DC.
+ *			level of the LCD when:
+ *			- the power changes from AC to DC (ACPI appendix B)
+ *			- a brightness hotkey gets pressed (implied by Win7/8 backlight docs)
  *  Return Value:
  *		-EINVAL	wrong arg.
  */
-- 
2.23.0

