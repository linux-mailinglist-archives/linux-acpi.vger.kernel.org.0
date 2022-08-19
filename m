Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA905999BC
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Aug 2022 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbiHSKWO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Aug 2022 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346861AbiHSKWL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Aug 2022 06:22:11 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45AAEF9FB
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2022 03:22:10 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a8so4194395pjg.5
        for <linux-acpi@vger.kernel.org>; Fri, 19 Aug 2022 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=bAiEuo64A6Mtpwz4IxtyDQGU691lfx4MUYTNz+pooqg=;
        b=ZTF1hiWzCDGbhkHOBAfavPEyp7gOkwfbIWLoGuIghHBzOggTkB2IdZHxC6T0S7xO48
         D0ePVE4fub+5Ik+3by7WBMjgfo6O/ZUGW7rlCmR5m9a3N0PNLakBJRMZiZnBkWiftHLO
         X8egqYqs4o6E597R63yLdnfP0/6pUFx+9jrk58ZuvckFgLFNAUCxrf3pJqpgKsWa8S2x
         tfjSl5/C2XAMk6PSDOP/Y06XPYtwyfnN+jyNFtXFyC4o3Wt0f7ZgnDPskSGiC10DbEYN
         CtE/DB4tskLoNccTCwJbw2l4yc0kC7EsjOELLa9F33DNRE3JTA6P+WI9j3pJTx9iezCF
         AUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=bAiEuo64A6Mtpwz4IxtyDQGU691lfx4MUYTNz+pooqg=;
        b=H/H1t5IhOsffGqmD6OWTltomt8Z1OVLRxGp/IJGqweGgfCL8e4utOxBDqX8p1UHNot
         a8GmFnmU/domqNaXL5p/tO6Bq6oHzBUocQ55EYm0MbCMaRVrw1a3tJl9y3UpPI4K1Xwp
         BWMNpOUQqiAP9jPc4zI6QldsmQDq1O1JcT+D3w/egvMC06GLhZIj/f+N26yfsNBnNAe5
         iTLMqbsnUCW26MeHI8eaBf3NzL27daiddhYnS07B82rc++Ela2n3C2QgpZo5ZbLeZZ7X
         KMKU3rQyg5/4KZhcQzvI9Qf+RP87ZbZtk8w/1GwLkJuwfjO/C48e/bAVRqNaVXT2cNM3
         tq5A==
X-Gm-Message-State: ACgBeo1uEoweI/KPiRdWjEjwMwmR0wlkCcFiu5PQhe6UViY5Pyh/Um3K
        pKRlKU6OJlf+ar80/j5er5wbWsLApeixzn9xk9c=
X-Google-Smtp-Source: AA6agR5/EscVnAoxeuzh1biYh/syEFPTJaVYJdi9/h3CeW6CUy8nN8+NJNlcciXyyJshr/4cCpDJLplWH2LqDZRuXWc=
X-Received: by 2002:a17:902:8b87:b0:16f:1bb7:984a with SMTP id
 ay7-20020a1709028b8700b0016f1bb7984amr6527145plb.113.1660904530142; Fri, 19
 Aug 2022 03:22:10 -0700 (PDT)
MIME-Version: 1.0
Sender: amuk030@gmail.com
Received: by 2002:a05:6a11:49c:b0:298:e503:2740 with HTTP; Fri, 19 Aug 2022
 03:22:09 -0700 (PDT)
From:   Mrs Cornelia Pascal <corneliapascal001@gmail.com>
Date:   Fri, 19 Aug 2022 03:22:09 -0700
X-Google-Sender-Auth: 0VkBJXxnuL5Vujxr6Rx_hiSg6wM
Message-ID: <CAKKnXprpu7tzcbwuf0bxELSCC8y0ObpAa6Oa0=NNoHR9X7dUWA@mail.gmail.com>
Subject: Get Back To Me
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Beloved,

I am Mrs. Cornelia Pascal. an aging widow suffering from Cancer
illness  .I have some funds Which I have inherited from my late
husband, the sum of  ($10.9 Million Dollars) And I needed a very
honest and sincere Individual  or co-operate organization that will
use the fund for work of humanity, I found your email address from the
Human resources data base and decided to contact you.

Please if you would be able to use the funds for the work  of humanity
as I have stated here in order to fulfill my late husband  wishes
please, kindly reply me back.

Thanks.
Regards,
Mrs.Cornelia Pascal
