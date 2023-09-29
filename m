Return-Path: <linux-acpi+bounces-285-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885657B3293
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 14:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id AAD751C209F2
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 12:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201419BCD
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Sep 2023 12:31:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AEB15AD5
	for <linux-acpi@vger.kernel.org>; Fri, 29 Sep 2023 10:42:10 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10FD11F;
	Fri, 29 Sep 2023 03:42:08 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c0ab18e084so1789313a34.1;
        Fri, 29 Sep 2023 03:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695984128; x=1696588928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcUuUTxHE+IHvmXlS2b4MsOM48ntcJUB+u6xduxAjxk=;
        b=Pihz36Vg2SuozjE+xkx11OuuE6jff1m+mXJrxdAJ2cYFKsNRyHtRwkuFW6RgYnm2pG
         W9YDPd3rFepM7IGJ65kEpzEdNvSXB3lWZ6Cd0+IHcg8YIRIaPCDSO+cjhoSXJeytmDK9
         WnoCOJnxdqm2I7vjEke4CRNSsPOHK/8JZBiUR0+lwrEosNILFLeN3kinYyJ1UunWtGlV
         x3d7vvjl1TCX9Vr7DMHwXoLZ/qSN3Ge7iLk8U+rScrQX63jJOnsqBumz+oskHibEr3ok
         SenMxKaFcAVmW1UKuNP2j5nVJFPNFeBFOtSJp7HneoLzy/3T+frN8E+qTUsva3yJzPFF
         uOAg==
X-Gm-Message-State: AOJu0YyeI+WJT/RA8Z7zc7runSdsLLVRXW6uY6d3YfSyNh0+T8WYF2xG
	WS/lJDZgNfgDlBC3oOfXT2dLRaz4PyWSKZi9KHc=
X-Google-Smtp-Source: AGHT+IH2vK2rMsAQcRdorevpcmoViAnxxTToVLEq3vLvwTgXPtBXFnhaeTwdC9FjzGOFjrmTWlk6hcuYHOALG0Grj7k=
X-Received: by 2002:a05:6808:2029:b0:3a9:e85d:b689 with SMTP id
 q41-20020a056808202900b003a9e85db689mr4974355oiw.0.1695984127991; Fri, 29 Sep
 2023 03:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202309290642.18zicoLj-lkp@intel.com>
In-Reply-To: <202309290642.18zicoLj-lkp@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Sep 2023 12:41:56 +0200
Message-ID: <CAJZ5v0gPjD-DiV6yM-vhrdQ-JJU097ErHZv4cAOVcuQMrEg0iw@mail.gmail.com>
Subject: Re: [rafael-pm:bleeding-edge 86/94] drivers/acpi/utils.c:427:
 warning: Function parameter or member 'list2' not described in 'acpi_handle_list_equal'
To: kernel test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, oe-kbuild-all@lists.linux.dev, 
	linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, 
	Vicki Pfau <vi@endrift.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 12:26=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it bleeding-edge
> head:   2cff74feed4a2a3a1c220e0ee2838b85b08d4999
> commit: 2f5042ef239e43d2b02f7724714673e5e604bd6f [86/94] ACPI: utils: Dyn=
amically determine acpi_handle_list size
> config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/2=
0230929/202309290642.18zicoLj-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230929/202309290642.18zicoLj-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309290642.18zicoLj-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/acpi/utils.c:427: warning: Function parameter or member 'list2=
' not described in 'acpi_handle_list_equal'
> >> drivers/acpi/utils.c:427: warning: Excess function parameter 'List2' d=
escription in 'acpi_handle_list_equal'

Typo in a kerneldoc comment - fixed up in the tree.

Thanks!

> vim +427 drivers/acpi/utils.c
>
>    416
>    417  /**
>    418   * acpi_handle_list_equal - Check if two ACPI handle lists are th=
e same
>    419   * @list1: First list to compare.
>    420   * @List2: Second list to compare.
>    421   *
>    422   * Return true if the given ACPI handle lists are of the same siz=
e and
>    423   * contain the same ACPI handles in the same order.  Otherwise, r=
eturn false.
>    424   */
>    425  bool acpi_handle_list_equal(struct acpi_handle_list *list1,
>    426                              struct acpi_handle_list *list2)
>  > 427  {
>    428          return list1->count =3D=3D list2->count &&
>    429                  !memcmp(list1->handles, list2->handles,
>    430                          list1->count * sizeof(acpi_handle));
>    431  }
>    432  EXPORT_SYMBOL_GPL(acpi_handle_list_equal);
>    433
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

