Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B608438C3D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Oct 2021 00:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhJXWJY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Oct 2021 18:09:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:37775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhJXWJX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 24 Oct 2021 18:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635113217;
        bh=Pgk5sI5E8F8/qyIS9GAXaMmz0H9l22npuvWEwucuoy4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PXMU89W0doz1RelCv3iRiJ82p5HI0H9/sJ9UeCNZ+RggrAIA+4tLguKeYMYBy7Wg7
         2UZFgh5/UOgyye96tOMBOZ6oEUGjnBza4tBj+BiMYz2VZvb3eA9EIxYjfXFAH3oeXd
         s5uuvZywQuLwIksNsDN8ZHmv66h6UlFXGY5YDan8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.131]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MAwbz-1mXuxc0K3V-00BL8d; Mon, 25 Oct 2021 00:06:57 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id DF88427F489; Sun, 24 Oct 2021 15:06:46 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Schaeckeler <schaecsn@gmx.net>
Subject: [PATCH] ACPI: AC: Quirk GK45 to skip reading _PSR
Date:   Sun, 24 Oct 2021 15:04:45 -0700
Message-Id: <20211024220446.2873-1-schaecsn@gmx.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hAX5y4v0PR2hBCCFKwVrPaCSmQOBlhIv82YFUXfPdDFUiET06na
 sqbhQWn2tPlZ6AOsAfkb+zLl6Uyxpi3ov+Q85yOacum+6Ahe7Qd8fqMqAHLD3LMfvpLEzd+
 zPXrLWZAaDdk2bZ055eWLQ5qRddOykzOSdk66YMESN2hf5XCh6EBz5JpC1bi1TmSZdXYNCH
 TkYMloifs/xgR8h9ewPow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WGvBVfFvGRI=:rTGq0xMNngw5sl/hGSA38V
 aOMPDacPkh8DSGlcKT/wnqKHQY6ssHvEog3hYhecWo8ZtYCcPgmSbXF7l0Fyz55dpZo9pwCjj
 8cg7qzy4iwkdfdU63TsDxfrMc+e70bZ/ZczGsMTW4EudAZ80ewzJIRjOqi6yfNvV3ubHRzKfn
 k6Zam5WExBkjuD2rySjpP1TgsqVZQsigI/Vlhexgj7St/lAFZRtDpRuH9uf+dO58IEvEBLI45
 8I2qzRIZ0nLDErTYGLI5adY2wn2hcD1CQh8v+bkxg1vrypjVdscMWDVGNckbU5D1xDpO63oRX
 xh+pSwr+Iu7hvRT95Ncz/sOwv46GVL/jt5ZVQdZGsXmn7f9KvPH6J2Q+LjYVYPHiYTLnt78eG
 iwLYaVMldiFYx65dLjK/5l750r3bYO7Hjr8cKVqfGUh1ccLIWAj74TJrHCC0Aq+8KjbRU+guG
 0YmGHVWRZ3RlMNBbAXOLEogFeSnHC384aIDaOg+f4lxExA2psyOi7cf2+3ZSUWh5Tu5f8Ggqb
 T35o7W7vc2rszQ6vu9fQd5fRP4EWutvbnHFzMhQcoAOCvkkIN60cid/zZh67TKmfVTCChZS6w
 Ri9pJn1m67w4DAqvxYy7irNc/UAg8rHn3kQok7ty8fhiqNQZBqhWcGxlGT8Ig6z0u5XrWwTfV
 dgJklXr/PEaYbsmLcE6K8btqlispfFAAXib81F6hd7+cLSqGLvQJM3eZ7dNCWEg9q4wQCasnb
 XQcflkcHg3hAJDEWKB11xTu2gcMhy4KmFNp+BkVdV8F33v5xUCH3gOmYNTSfemBf0OOQA6AEc
 FRMtT6bQyl44ssopqjtPgG66SeblVm9js/SMepVa+KrOhQ4b9NOf/SNofLMP32FBYExuAuNoS
 Ac1dsgWlhaLtLwxys5QqeoMvso0W3nYB7K9RsvMMJ9cF7V/+iJcczcWHbZJ2dyn4QZIhKldku
 AWl+fR3A3QehDWLpIdSsVQh1CEhnV0yfkOCrG55BgyTv101Zk0LuXBt/WvjapOirsS83rWVjp
 nKfKMai6qTSgrPNRjSKNu4DxX7DkhW7BEktMz1lJF4rQanTNZ/aNsVVOKpsEhkzHutE0dVViI
 14FTEy55YXHPsQ=
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let GK45 not go into BIOS for determining the AC power state. BIOS wrongly
returns 0. Hardcode the power state to 1.

The mini PC GK45 by Besstar Tech Lld. (aka Kodlix) just runs off AC. It
does not include any batteries. Nevertheless BIOS reports AC off:

root@kodlix:/usr/src/linux# cat /sys/class/power_supply/ADP1/online
0

root@kodlix:/usr/src/linux# modprobe acpi_dbg
root@kodlix:/usr/src/linux# tools/power/acpi/acpidbg

- find _PSR
   \_SB.PCI0.SBRG.H_EC.ADP1._PSR Method       000000009283cee8 001 Args 0 =
Len 001C Aml 00000000f54e5f67

- execute \_SB.PCI0.SBRG.H_EC.ADP1._PSR
Evaluating \_SB.PCI0.SBRG.H_EC.ADP1._PSR
Evaluation of \_SB.PCI0.SBRG.H_EC.ADP1._PSR returned object 00000000dc08c1=
87, external buffer length 18
 [Integer] =3D 0000000000000000

that should be

 [Integer] =3D 0000000000000001

Signed-off-by: Stefan Schaeckeler <schaecsn@gmx.net>
=2D--
 drivers/acpi/ac.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index b0cb662233f1..81aff651a0d4 100644
=2D-- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -61,6 +61,7 @@ static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resum=
e);

 static int ac_sleep_before_get_state_ms;
 static int ac_check_pmic =3D 1;
+static int ac_only;

 static struct acpi_driver acpi_ac_driver =3D {
 	.name =3D "ac",
@@ -93,6 +94,11 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
 	if (!ac)
 		return -EINVAL;

+	if (ac_only) {
+		ac->state =3D 1;
+		return 0;
+	}
+
 	status =3D acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
 				       &ac->state);
 	if (ACPI_FAILURE(status)) {
@@ -200,6 +206,12 @@ static int __init ac_do_not_check_pmic_quirk(const st=
ruct dmi_system_id *d)
 	return 0;
 }

+static int __init ac_only_quirk(const struct dmi_system_id *d)
+{
+	ac_only =3D 1;
+	return 0;
+}
+
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id ac_dmi_table[]  __initconst =3D {
 	{
@@ -209,6 +221,13 @@ static const struct dmi_system_id ac_dmi_table[]  __i=
nitconst =3D {
 			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
 		},
 	},
+	{
+		/* Kodlix GK45 returning incorrect state */
+		.callback =3D ac_only_quirk,
+		.matches =3D {
+			DMI_MATCH(DMI_PRODUCT_NAME, "GK45"),
+		},
+	},
 	{
 		/* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
 		.callback =3D ac_do_not_check_pmic_quirk,
=2D-
2.30.2

