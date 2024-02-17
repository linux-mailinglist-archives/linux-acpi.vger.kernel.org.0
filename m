Return-Path: <linux-acpi+bounces-3636-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D14858E72
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Feb 2024 10:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1041F22133
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Feb 2024 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4021D54B;
	Sat, 17 Feb 2024 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPqEP7JZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDB1D526;
	Sat, 17 Feb 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708163530; cv=none; b=V1XWA28hOUiaacMwT+grgwfv1oo+EffcFPcPYKEvFdrL2j6Rbd74Gh12XwKMAHdZODmi7VlcDr+p5fSU/7DAOlZoUcgjpJ9b0pOEyUvwtXWAKfB92RMWxKm/xpiajq3qqXYnZNagQuUgMKF5tKdB7k4LHQawpdc46JhZoepCnUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708163530; c=relaxed/simple;
	bh=1YL0IucvWTkie2pHwoVyF1SG1FtwSaiJi2Wu2eQoHms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4aPFcjs53HuuhjL3kQLkJvt3GV24JC8dF46BzcBr2CZzKNqzFPpAbM+vpQ/+v0C07JsQvPWnAtzijgETSy3VV23TubzU6jq4JlHCfYVReDySKst3dtqdNRJ7pMmm8RKpEpYgnP1M31dIwOuq9xGZ8byXnZUHm7GjSIWxVtpXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPqEP7JZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708163525; x=1739699525;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1YL0IucvWTkie2pHwoVyF1SG1FtwSaiJi2Wu2eQoHms=;
  b=MPqEP7JZKqLBPfEpQEFRu+zTS0YkM+FttaQhOpkeeAeCRlIGFIb8okIV
   1WpRyQjYZIB0O1DILTidK2BF5f5biyoTsTh4sxVX8/F3/QO8lHXjw23g3
   3l8VRFZN8/tMLJZOodBzsb6KT5CKpCU4MFdpWYSiRyIVe4ytcBggqcIaw
   mvRy37Ce1W7vXYeBrSkPXu833ghuZnbkj3FHHU53v4vPeP4uNhrikO9Hy
   Skbor7LSlWXgLdSiL6XoZrY5aU8uLXa362UQ3BVWfIEztXmG1Na1tNtdM
   ntmfzvhP+ljmb9sux8j9yVAFmh0w7HwjGgly2TgyhmjecWrT0N0RE9Tk1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12844065"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="12844065"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 01:52:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="935978120"
X-IronPort-AV: E=Sophos;i="6.06,166,1705392000"; 
   d="scan'208";a="935978120"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2024 01:51:58 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbHMS-00021M-0B;
	Sat, 17 Feb 2024 09:51:56 +0000
Date: Sat, 17 Feb 2024 17:51:21 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Melissa Wen <mwen@igalia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v6 1/5] drm: Stop using `select ACPI_VIDEO` in all drivers
Message-ID: <202402171727.maolcPXi-lkp@intel.com>
References: <20240214215756.6530-2-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214215756.6530-2-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm-intel/for-linux-next-fixes drm-tip/drm-tip linus/master v6.8-rc4 next-20240216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/drm-Stop-using-select-ACPI_VIDEO-in-all-drivers/20240215-055936
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240214215756.6530-2-mario.limonciello%40amd.com
patch subject: [PATCH v6 1/5] drm: Stop using `select ACPI_VIDEO` in all drivers
config: alpha-kismet-CONFIG_FB_BACKLIGHT-CONFIG_HT16K33-0-0 (https://download.01.org/0day-ci/archive/20240217/202402171727.maolcPXi-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240217/202402171727.maolcPXi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402171727.maolcPXi-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for FB_BACKLIGHT when selected by HT16K33
   .config:210:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_Y
   .config:243:warning: symbol value 'n' invalid for SATA_MOBILE_LPM_POLICY
   .config:338:warning: symbol value 'n' invalid for PSTORE_BLK_MAX_REASON
   .config:435:warning: symbol value 'n' invalid for KFENCE_SAMPLE_INTERVAL
   .config:437:warning: symbol value 'n' invalid for AIC79XX_DEBUG_MASK
   .config:521:warning: symbol value 'n' invalid for USB_GADGET_STORAGE_NUM_BUFFERS
   .config:618:warning: symbol value 'n' invalid for DRM_XE_JOB_TIMEOUT_MIN
   .config:632:warning: symbol value 'n' invalid for CRYPTO_DEV_QCE_SW_MAX_LEN
   .config:739:warning: symbol value 'n' invalid for PANEL_LCD_CHARSET
   .config:759:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_BAUDRATE
   .config:771:warning: symbol value 'n' invalid for SCSI_MESH_RESET_DELAY_MS
   .config:796:warning: symbol value 'n' invalid for SND_AC97_POWER_SAVE_DEFAULT
   .config:834:warning: symbol value 'n' invalid for MAGIC_SYSRQ_DEFAULT_ENABLE
   .config:851:warning: symbol value 'n' invalid for DRM_I915_MAX_REQUEST_BUSYWAIT
   .config:890:warning: symbol value 'n' invalid for SND_AT73C213_TARGET_BITRATE
   .config:892:warning: symbol value 'n' invalid for AIC79XX_CMDS_PER_DEVICE
   .config:907:warning: symbol value 'n' invalid for DRM_XE_PREEMPT_TIMEOUT_MIN
   .config:913:warning: symbol value 'n' invalid for NET_EMATCH_STACK
   .config:915:warning: symbol value 'n' invalid for VMCP_CMA_SIZE
   .config:973:warning: symbol value 'n' invalid for PANEL_LCD_PIN_SDA
   .config:1006:warning: symbol value 'n' invalid for PANEL_LCD_PIN_E
   .config:1142:warning: symbol value 'n' invalid for RCU_CPU_STALL_TIMEOUT
   .config:1170:warning: symbol value 'n' invalid for MTDRAM_ERASE_SIZE
   .config:1431:warning: symbol value 'n' invalid for LEGACY_PTY_COUNT
   .config:1581:warning: symbol value 'n' invalid for WATCHDOG_OPEN_TIMEOUT
   .config:1588:warning: symbol value 'n' invalid for AIC7XXX_RESET_DELAY_MS
   .config:1752:warning: symbol value 'n' invalid for IBM_EMAC_POLL_WEIGHT
   .config:1867:warning: symbol value 'n' invalid for DRM_I915_STOP_TIMEOUT
   .config:2098:warning: symbol value 'n' invalid for AIC79XX_RESET_DELAY_MS
   .config:2129:warning: symbol value 'n' invalid for SND_HDA_PREALLOC_SIZE
   .config:2176:warning: symbol value 'n' invalid for RCU_FANOUT_LEAF
   .config:2186:warning: symbol value 'n' invalid for KCOV_IRQ_AREA_SIZE
   .config:2307:warning: symbol value 'n' invalid for DRM_XE_TIMESLICE_MAX
   .config:2321:warning: symbol value 'n' invalid for PANEL_LCD_BWIDTH
   .config:2386:warning: symbol value 'n' invalid for XEN_MEMORY_HOTPLUG_LIMIT
   .config:2439:warning: symbol value 'n' invalid for VERBOSE_MCHECK_ON
   .config:2559:warning: symbol value 'n' invalid for PANEL_PARPORT
   .config:2645:warning: symbol value 'n' invalid for NOUVEAU_DEBUG_DEFAULT
   .config:2744:warning: symbol value 'n' invalid for MTD_REDBOOT_DIRECTORY_BLOCK
   .config:2803:warning: symbol value 'n' invalid for SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST_NUM
   .config:2831:warning: symbol value 'n' invalid for KCSAN_REPORT_ONCE_IN_MS
   .config:2928:warning: symbol value 'n' invalid for KCSAN_UDELAY_INTERRUPT
   .config:2952:warning: symbol value 'n' invalid for PANEL_LCD_PIN_BL
   .config:2969:warning: symbol value 'n' invalid for DEBUG_OBJECTS_ENABLE_DEFAULT
   .config:2977:warning: symbol value 'n' invalid for INITRAMFS_ROOT_GID
   .config:3081:warning: symbol value 'n' invalid for ATM_FORE200E_TX_RETRY
   .config:3120:warning: symbol value 'n' invalid for FB_OMAP2_DSS_MIN_FCK_PER_PCK
   .config:3186:warning: symbol value 'n' invalid for PSTORE_BLK_CONSOLE_SIZE
   .config:3335:warning: symbol value 'n' invalid for BOOKE_WDT_DEFAULT_TIMEOUT
   .config:3389:warning: symbol value 'n' invalid for KCSAN_UDELAY_TASK
   .config:3453:warning: symbol value 'n' invalid for MMC_BLOCK_MINORS
   .config:3499:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_SYNC
   .config:3620:warning: symbol value 'n' invalid for UCLAMP_BUCKETS_COUNT
   .config:3726:warning: symbol value 'n' invalid for SERIAL_MCF_BAUDRATE
   .config:3794:warning: symbol value 'n' invalid for DE2104X_DSL
   .config:3806:warning: symbol value 'n' invalid for BLK_DEV_RAM_COUNT
   .config:3811:warning: symbol value 'n' invalid for FTRACE_RECORD_RECURSION_SIZE
   .config:3980:warning: symbol value 'n' invalid for STACK_MAX_DEFAULT_SIZE_MB
   .config:4203:warning: symbol value 'n' invalid for USBIP_VHCI_HC_PORTS
   .config:4204:warning: symbol value 'n' invalid for INPUT_MOUSEDEV_SCREEN_X
   .config:4317:warning: symbol value 'n' invalid for RIONET_RX_SIZE
   .config:4529:warning: symbol value 'n' invalid for RADIO_TYPHOON_PORT
   .config:4624:warning: symbol value 'n' invalid for IBM_EMAC_TXB
   .config:4651:warning: symbol value 'n' invalid for SERIAL_TXX9_NR_UARTS
   .config:5012:warning: symbol value 'n' invalid for ARCH_MMAP_RND_BITS
   .config:5033:warning: symbol value 'n' invalid for PANEL_LCD_PIN_RW
   .config:5093:warning: symbol value 'n' invalid for DRM_I915_FENCE_TIMEOUT
   .config:5115:warning: symbol value 'n' invalid for TTY_PRINTK_LEVEL
   .config:5272:warning: symbol value 'n' invalid for MIPS_EJTAG_FDC_KGDB_CHAN
   .config:5367:warning: symbol value 'n' invalid for KDB_DEFAULT_ENABLE
   .config:5384:warning: symbol value 'n' invalid for SERIAL_ALTERA_UART_MAXPORTS
   .config:5517:warning: symbol value 'n' invalid for PPC_EARLY_DEBUG_EHV_BC_HANDLE
   .config:5619:warning: symbol value 'n' invalid for SND_MAX_CARDS
   .config:5648:warning: symbol value 'n' invalid for PANEL_LCD_HWIDTH
   .config:5678:warning: symbol value 'n' invalid for LOCKDEP_CHAINS_BITS
   .config:5766:warning: symbol value 'n' invalid for DRM_I915_HEARTBEAT_INTERVAL
   .config:5772:warning: symbol value 'n' invalid for KCSAN_SKIP_WATCH
   .config:5780:warning: symbol value 'n' invalid for RCU_BOOST_DELAY
   .config:5796:warning: symbol value 'n' invalid for PSTORE_BLK_KMSG_SIZE
   .config:5897:warning: symbol value 'n' invalid for CRYPTO_DEV_FSL_CAAM_INTC_TIME_THLD
   .config:6089:warning: symbol value 'n' invalid for ARCH_MMAP_RND_COMPAT_BITS
   .config:6238:warning: symbol value 'n' invalid for DRM_XE_PREEMPT_TIMEOUT_MAX
   .config:6254:warning: symbol value 'n' invalid for RADIO_TRUST_PORT
   .config:6321:warning: symbol value 'n' invalid for SERIAL_SH_SCI_NR_UARTS
   .config:6627:warning: symbol value 'n' invalid for CMA_SIZE_PERCENTAGE
   .config:6743:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_MAX_TAGS
   .config:6771:warning: symbol value 'n' invalid for DRM_XE_TIMESLICE_MIN
   .config:6873:warning: symbol value 'n' invalid for SCSI_NCR53C8XX_MAX_TAGS
   .config:6875:warning: symbol value 'n' invalid for DVB_MAX_ADAPTERS
   .config:6886:warning: symbol value 'n' invalid for RIONET_TX_SIZE
   .config:6892:warning: symbol value 'n' invalid for SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
   .config:7206:warning: symbol value 'n' invalid for OMAP2_DSS_MIN_FCK_PER_PCK
   .config:7237:warning: symbol value 'n' invalid for ZSMALLOC_CHAIN_SIZE
   .config:7239:warning: symbol value 'n' invalid for SERIAL_ARC_NR_PORTS
   .config:7258:warning: symbol value 'n' invalid for IBM_EMAC_RXB
   .config:7412:warning: symbol value 'n' invalid for SCSI_MPT3SAS_MAX_SGE
   .config:7466:warning: symbol value 'n' invalid for LOCKDEP_BITS
   .config:7543:warning: symbol value 'n' invalid for PSTORE_DEFAULT_KMSG_BYTES
   .config:7588:warning: symbol value 'n' invalid for RCU_FANOUT
   .config:7637:warning: symbol value 'n' invalid for PANEL_LCD

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

