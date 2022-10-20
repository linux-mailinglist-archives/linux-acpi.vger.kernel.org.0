Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A12460709E
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Oct 2022 08:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJUG7F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 21 Oct 2022 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJUG7E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Oct 2022 02:59:04 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5AC244708
        for <linux-acpi@vger.kernel.org>; Thu, 20 Oct 2022 23:59:01 -0700 (PDT)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGJsWRWlGSWpSXmKPExsWyc0WAsq6Rc1C
  ywbFDohbXnh5gsvg0YQ+7xePdO1gtej/0sFrcunyd1eLM+UdsFneufWCx6LvqZ3Hl5gU2i/5X
  +1gs9r2YyWKxd14Hm8Xyff2MFnsPAtVunNDHbnH1cRujxYWPK9kt2r4/Z7e4MnUyo8WK5hssD
  iIen5fNZPNo+HqSyWPvrWyPX21zmT26V35l8zjd9YnF4+OpE4weB1pFPWasfsTmcffWJSaP2x
  Oes3rsufGJ2ePrm042j7cXlzB7bD5d7dF/bRlzgGAUa2ZeUn5FAmvG0S09rAXrmSr+XbjE3MD
  YwNTFyMkhJFAisbHrLmMXIwcHr4CdxN3V+SBhZgE9iRtTp7CB2LwCghInZz5hgYhrSyxb+JoZ
  pJxZQE3ia1cJSFhYwETi792drCBhEQEViTc7uEHCbEBT9rd8ZgexWQRUJfY9bGaFWCojcXlRI
  9sERu5ZSJbNQrJsFpJlsxCWLWBkWcVoVpxaVJZapGtoppdUlJmeUZKbmJmjl1ilm6iXWqpbnl
  pcomukl1herJdaXKxXXJmbnJOil5dasokRGJ0pxYpbdzDeWPZH7xCjJAeTkiivkEJQshBfUn5
  KZUZicUZ8UWlOavEhRj0ODoELZx9+YhS48uFTE5MUS15+XqqSBO8UR6BqwaLU9NSKtMwcYDKB
  aZDg4FES4X3nAJTmLS5IzC3OTIdInWLM59i+c/9eZo7dx88DySXfLwLJfx+vAMkHB64Byamz/
  +0HioPJ5WByFZic+bXtADPH121dQPL0n+kHmIXArpAS5/0GcoUAyJqM0jy4I2DJ9RKjrJQwLy
  MDA4MQT0FqUW5mCar8K0ZxDkYlYV4vkCk8mXklcLe+AnqDCegN0y1+IG+UJCKkpBqYTN20Zl5
  4MPHEZ7eLs43e1WVlXcn7eULr0bd+Qz7OBY4yS3Ycsk1fJdq+Z9X6G1kLDK4JGtQ/1DE4cSSL
  da9nree168GJLsuTQ79le1Rn+UrGrpH/fVSnnv/jq5RpMgV/nwou5TZayL2zqW/ThLnPlrIce
  JOvmdU4ryIm7+6fXPVXMrwnpx/7s2htt+r+BJF5avpPv2xbcvxl4I5p5mGvZhTu+VQRsY05nz
  /yzcGkF/lnFG9IPLyYHLCglUlsWszlKz+sZm09Jla8XL0hqC6wbPW20P/STMl1SlOu8bVZXq+
  cZB2mvmiejV7Gv7XhDwpu7YuZd+dqbVKL8b35gbGrXu5v5v+/cvOBkFUTm+85lyqxFGckGmox
  FxUnAgAw3LDKKQQAAA==
X-Env-Sender: tianasime@gmail.com
X-Msg-Ref: server-4.tower-539.messagelabs.com!1666335537!213561!1
X-Originating-IP: [185.168.80.35]
X-SYMC-ESS-Client-Auth: outbound-route-from=fail
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6895 invoked from network); 21 Oct 2022 06:58:58 -0000
Received: from unknown (HELO VSRVDCF1106) (185.168.80.35)
  by server-4.tower-539.messagelabs.com with SMTP; 21 Oct 2022 06:58:58 -0000
Received: from [194.99.45.27] (Unknown [194.99.45.27])
        by VSRVDCF1106 with ESMTP
        ; Thu, 20 Oct 2022 17:03:02 +0200
Message-ID: <58729B0D-9AFA-48DE-8470-1F53AFE3A27D@VSRVDCF1106>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: RE; Dear Customer we are still waiting!!!!!
To:     Recipients <tianasime@gmail.com>
From:   Mrs Sonia Anderson <tianasime@gmail.com>
Date:   Thu, 20 Oct 2022 08:02:59 -0700
Reply-To: bo979685@gmail.com
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEM_REPTO,T_HK_NAME_FM_MR_MRS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [195.245.231.1 listed in list.dnswl.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [194.99.45.27 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5594]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tianasime[at]gmail.com]
        *  0.7 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  0.0 DKIM_ADSP_CUSTOM_MED No valid author signature, adsp_override
        *      is CUSTOM_MED
        *  1.0 FORGED_GMAIL_RCVD 'From' gmail.com does not match 'Received'
        *      headers
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [bo979685[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [195.245.231.1 listed in wl.mailspike.net]
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.9 NML_ADSP_CUSTOM_MED ADSP custom_med hit, and not from a mailing
        *       list
        *  2.5 SPOOFED_FREEM_REPTO Forged freemail sender with freemail
        *      reply-to
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Bank of America
Charlotte, North Carolina, United States
North Tryon Street, Charlotte, NC 28255
Text/Fax: Ext-8-1-0880.050.640
email;bo979685@gmail.com

Dear Customer,

We are still waiting for your reply to our last email which was sent to you .

Thanks,
Sonia Anderson
Financial Inquiries Unit 

