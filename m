Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE846892E
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Dec 2021 05:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhLEEzJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Dec 2021 23:55:09 -0500
Received: from mail1.bemta31.messagelabs.com ([67.219.246.113]:35033 "EHLO
        mail1.bemta31.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhLEEzI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Dec 2021 23:55:08 -0500
Received: from [100.114.1.131] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.us-east-1.aws.ess.symcld.net id D9/30-00473-6554CA16; Sun, 05 Dec 2021 04:51:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTe0xTZxjG+c7p6elmy2px4Ygsw5q5TWzXwiI
  vbCwOxZzpso0s2eayDQ9SaB0tpC0Bly0jgDLYIojInU46rFwVLJFrcdwkgECkA5EhFwFRoVws
  CxsDu1anY//88uR93jzf88f7cXCBje3GkcVqZWoVEyFkP8/yX95mEH0SWM5IbrV7QZY+iYCxj
  tdgxlCFYLjIyIbzdxoQGAuGSbg5bENwM8FGwnJeExtsU/EIklbOYxC3bsCg7UYaAfnZfQQkx7
  ciONmsI2EwbxwHY8YVFlSYO3G4ltZMwuJ6Ag69mSUELGQn4XD3YQ4J8ZZ0BPWZNBTfqEbQdVo
  EE7VnCbCWjxOgv51PQHvjABtWLk5j8IOtCIPe7n1QaF1gw2B9I4KW35pxWL93B4Mk3TSC2aQB
  HDJHLQiSG5sIMGY1EGDJPYXgj9olAi40pSKwPLyKwJA4S8L8FSO514v+uXSCRacU+NLNtksYX
  TmyStCFRWaMTlv8nj6pKyDostJijH60WmrH5TKSnk+tYdOPGkYRfcHQRdBdk6/TP1Z3Itqkqy
  c/2vU5oVCFRMYeIeTFc9eJqDUU23u2HYtDAygFPccR8CsQVWxWOzSL70nZTL+zHJrN96fis3q
  IFMSx7+yghsbDHWMXvoAa+nUJd2ge34dqy6kjHBrnv0qt6frxJ/plqsaS/+/OZqozZ4rliKH4
  HlRex2HHmOLvoe6l55AOvYXvThXkTRJpiJu7ISl3Q1LuhqRzCC9FfiFqRbhcq2QUESKpRCKSS
  t8U+YikPnvEzDciRhytEckYjVYkFTMxGrFMoxFrjiuPRoSKVTLtZWS/s1A1WVmLdD/9JW5BWz
  mY8EWebaSMETiHRIYelzMaebA6OkKmaUHuHI6Q4nn6ljOCzWpZuCw2TBFhv9anNsXhCrfwnPb
  bbZ4milFqFOFPrC4UxIm/X6DHOVXtOjtrHvPaY06XFtl5v85Bi4MClipSJXNz5Q3vswfxHUHy
  aNWzZ57+i370kpsLDzk5OQm4UTK1UqH9v/8AuXKQ0IU3EWBP4SpU2mdtHtiLYvaiX6SWOYpqm
  f8stzhMaOJ2zma9ETf0tj7Gtnp6E7tvhObFsErKEwP4ia9U7PRN1imzLda+c0YPpcLC1u08cF
  XmOjT2nt4c8C4KM+OTGSXfFboZYlvfif76z90Jpp4M098d/sTdxY7qusBDM/jMtyNRybFetNd
  R55U1z6kdQYl5ErJvwW9Ol0JetIhMR6x6fU3dqkl7oKdR0uZ3eH+KOSS31QPf3fTV7AdG695l
  81uY4eBSf1Vg99yY6UMJJa/0Nnsd27Q9wfl62KHgqoODA5/l5UbUOQdXtQd9PD068YJ+/ZcTt
  y3iEzLcL1XFjevkbZV7bxv/0j2z/9NbxrV0YZE3furM+ytnLnVnHLPOC1kaOSPdhas1zD9MYv
  xrkgQAAA==
X-Env-Sender: chew_lh@biomesciltlight.com
X-Msg-Ref: server-7.tower-706.messagelabs.com!1638679893!32675!1
X-Originating-IP: [61.244.27.166]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=biomesciltlight.com,-,-
X-VirusChecked: Checked
Received: (qmail 10704 invoked from network); 5 Dec 2021 04:51:34 -0000
Received: from mail.merkur-ltd.com (HELO mail.merkur-ltd.com) (61.244.27.166)
  by server-7.tower-706.messagelabs.com with SMTP; 5 Dec 2021 04:51:34 -0000
Received: from mail.merkur-ltd.com (mail.merkur-ltd.com [61.244.27.166])
        by mail.merkur-ltd.com (Postfix) with ESMTP id 2E86A134CE8D;
        Sun,  5 Dec 2021 12:51:27 +0800 (HKT)
Date:   Sun, 05 Dec 2021 12:51:27 +0800 (HKT)
From:   World Health Organization <chew_lh@biomesciltlight.com>
Reply-To: attorneyvicrayk@gmail.com
Subject: Good News
Message-ID: <5d919725-dd45-485f-b418-45f90cbaf59f@mail>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [102.89.3.147]
X-Mailer: Zimbra 7.1.0_GA_3140 (zclient/7.1.0_GA_3140)
To:     undisclosed-recipients:;
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



The World Health Organization has listed you among the 10 people to receive a corona relief fund of $500,000.00 USD. Send your full details
 including your mobile number through the email address below: attorneyvicrayk@gmail.com  for more information.

______________________________________________________________________
This email has been scanned by the Symantec Email Security.cloud service.
For more information please visit http://www.symanteccloud.com
______________________________________________________________________
