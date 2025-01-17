Return-Path: <linux-acpi+bounces-10736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E72A14D4A
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 11:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499C4162260
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A51F9422;
	Fri, 17 Jan 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bec/uA92";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w+ZLgO9j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bec/uA92";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w+ZLgO9j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47D1F76D8;
	Fri, 17 Jan 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108745; cv=none; b=YV8+3VvUs+85jkt1Z3JW3RR0izAtwO1LJLoInGji3qAg2G4Y2/NCbWfYhLrUCmffC+Vbp/rfTFDeGm/p1QL+XIKqnNGHULWrNnDUJXLq/RzQAIFI3mkrqcdTWkjcgKn9j0FhwwzbQuZ7XXYM29itItqz69B5wcQbz/NMxslhhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108745; c=relaxed/simple;
	bh=+KDdNh68EUuzpcXt1LQDIrshUWnf4LrJY36f5KAFNRs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ub3wvHCKd4Ru6E4svBYyIhc4KfX6pkl2rRh3YXcWZSaLDb7HC2t3e7n3wQYALASgaXj+nGbSDhK9urLMf/uxGDquH1cocQbOz9A4oRk7kiH1aiayCrKkZSrTuvRqB8y7O0hK+SIvz5TgmmGkdMiVKRVJSikabIiqyzCA1rdVTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bec/uA92; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w+ZLgO9j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bec/uA92; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w+ZLgO9j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 534961F387;
	Fri, 17 Jan 2025 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737108735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UYPd+XVlSAvEzY7I68e0sQgjCUIeCGc+yviRXWTvx4=;
	b=Bec/uA92Joza2VDej35FO1u7A3hXzUpv3SKtsVmeMQA5m00i3kLNnUpYvXYPGG/zBSh0D3
	KJdiHuNlbeNf1pB7WyRMwV51g+7MrFB1ENRxa8JRWr96esPKo6Z2GLY0PKGFyMe+acL37Q
	C1IAUNYLzjVvM+oT8UhW6hbw3QsrJY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737108735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UYPd+XVlSAvEzY7I68e0sQgjCUIeCGc+yviRXWTvx4=;
	b=w+ZLgO9judSqai/anSIkFG1mctc9AuwlLA0UmnFBr1qq3+p6asNePaODEG4hjRQq0WHFIT
	ZK0PJN9JDa+jTCBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737108735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UYPd+XVlSAvEzY7I68e0sQgjCUIeCGc+yviRXWTvx4=;
	b=Bec/uA92Joza2VDej35FO1u7A3hXzUpv3SKtsVmeMQA5m00i3kLNnUpYvXYPGG/zBSh0D3
	KJdiHuNlbeNf1pB7WyRMwV51g+7MrFB1ENRxa8JRWr96esPKo6Z2GLY0PKGFyMe+acL37Q
	C1IAUNYLzjVvM+oT8UhW6hbw3QsrJY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737108735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9UYPd+XVlSAvEzY7I68e0sQgjCUIeCGc+yviRXWTvx4=;
	b=w+ZLgO9judSqai/anSIkFG1mctc9AuwlLA0UmnFBr1qq3+p6asNePaODEG4hjRQq0WHFIT
	ZK0PJN9JDa+jTCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0F66139CB;
	Fri, 17 Jan 2025 10:12:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ODHLLf4simcJAgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 Jan 2025 10:12:14 +0000
Date: Fri, 17 Jan 2025 11:12:14 +0100
Message-ID: <87r051sq9t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc:<robh+dt@kernel.org>,<andriy.shevchenko@linux.intel.com>,
 <lgirdwood@gmail.com>,<perex@perex.cz>,<shenghao-ding@ti.com>,
 <navada@ti.com>,<13916275206@139.com>,<v-hampiholi@ti.com>,<v-po@ti.com>,
 <linux-sound@vger.kernel.org>,<linux-kernel@vger.kernel.org>,
 <liam.r.girdwood@intel.com>,<yung-chuan.liao@linux.intel.com>,
 <broonie@kernel.org>,<antheas.dk@gmail.com>,	"Rafael J. Wysocki"
 <rafael@kernel.org>,	linux-acpi@vger.kernel.org,	Hans de Goede
 <hdegoede@redhat.com>,	=?ISO-8859-1?Q?=22Ilpo_J=E4rvinen=22?=
 <ilpo.jarvinen@linux.intel.com>,	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v12] ALSA: hda/tas2781: Add tas2781 hda SPI driver
In-Reply-To: <87bjwnzw1i.wl-tiwai@suse.de>
References: <20241216122008.15425-1-baojun.xu@ti.com>
	<87bjwnzw1i.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,gmail.com,perex.cz,ti.com,139.com,vger.kernel.org,intel.com,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Fri, 03 Jan 2025 17:44:57 +0100,
Takashi Iwai wrote:
> 
> On Mon, 16 Dec 2024 13:20:08 +0100,
> Baojun Xu wrote:
> > 
> > This patch was used to add TAS2781 devices on SPI support in sound/pci/hda.
> > It use ACPI node descript about parameters of TAS2781 on SPI, it like:
> >     Scope (_SB.PC00.SPI0)
> >     {
> >         Device (GSPK)
> >         {
> >             Name (_HID, "TXNW2781")  // _HID: Hardware ID
> >             Method (_CRS, 0, NotSerialized)
> >             {
> >                 Name (RBUF, ResourceTemplate ()
> >                 {
> >                     SpiSerialBusV2 (...)
> >                     SpiSerialBusV2 (...)
> >                 }
> >             }
> >         }
> >     }
> > 
> > And in platform/x86/serial-multi-instantiate.c, those spi devices will be
> > added into system as a single SPI device, so TAS2781 SPI driver will
> > probe twice for every single SPI device. And driver will also parser
> > mono DSP firmware binary and RCA binary for itself.
> > The code support Realtek as the primary codec.
> > In patch version-10, add multi devices firmware binary support,
> > to compatble with windows driver, they can share same firmware binary.
> > 
> > Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> > 
> > ---
> > v12:
> >  - Reture real error in tas2781_save_calibration().
> >  - Change tas_priv->rcabin.profile_cfg_id to 0 after reset.
> >  - Add tas2781_spi_reset() in system suspend.
> >  - Remove apply_calibration in system resume, it will cause no sound.
> >  - Change unaligned.h include directory from asm to linux.
> > v11:
> >  - Define config number for pre-reset and post-reset scripts.
> >  - Remove acpi_subsystem_id as it was not used.
> >  - Change variables order in structure, to avoid possible memory holes.
> >  - Remove pre-reset and post-reset scripts in reset function.
> >  - Change variables name to more common.
> >  - Add pre-reset and post-reset scripts in fw_ready.
> >  - Add empty line after end of function.
> >  - Remove reset function before fw ready.
> >  - Add result check for tasdevice_spi_prmg_load().
> >  - Return real result of tasdevice_load_block_kernel().
> >  - Change code for ppcver check, and update debug message.
> >  - Remove load_calib_data() as no calibration data in firmware now.
> >  - Remove tasdevice_spi_select_tuningprm_cfg() as config will be forced
> >    downloaded after program download.
> >  - Change comments for tasdevice_spi_tuning_switch().
> >  - Remove unnecessary brace.
> > v10:
> >  - Remove project id 103c8b93 in Patch_realtek.c, as it was used
> >    for test only, offcial project id is 103c8daa (Gemtree).
> >  - Add TAS2781_REG_CLK_CONFIG for check if AMP has been reset.
> >  - Add table for pre-reset and post-reset.
> >  - Perform pre-reset config before reset AMP.
> >  - Perform post-reset config after reset AMP.
> >  - Fix wrong offset in calibration data issue.
> >  - Remove tuning switch after firmware download.
> >  - Force stop play in runtime suspend.
> >  - Apply patch for component change in bind & unbind.
> >  - Remove program download and calibration data apply,
> >    switch tuning only in runtime resume.
> >  - Check if AMP has reseted in system resume,
> >    and do firmware download and calibration data apply.
> >  - Change flag 0xCx to 0x8x for coeff data force download.
> >  - Add device index for multi device firmware binary file compatible.
> >  - Check device index before registers write during firmware download.
> >  - Force config data download after program download.
> >  - Remove config download in tuning switch.
> > v9:
> >  - Add parentheses for variables in micro define.
> >  - Add define for calibration registers address identify.
> >  - Change variable name from calibration_data to cali_data.
> >  - Add variable for calibration registers address in struct tasdevice_priv.
> >  - Change format for alignment to parentheses.
> >  - Remove tas2781_reg_defaults as it will be over write in firmware download.
> >  - Remove RESET for second device in tas2781_spi_reset(),
> >    as it will cause no sound on second device.
> >  - Add calibration registers address initial in tasdevice_spi_init().
> >  - Remove unnecessary parentheses.
> >  - Remove exception in tas2781_hda_playback_hook().
> >  - Remove hard code for calibration registers address.
> >  - Add support for calibration data format V3 for registers address identify,
> >    as new firmware tool will define calibration registers address dynamic,
> >    so can't hard code it, need read it from BIOS with calibration data.
> >  - Remove some debug print.
> >  - Change hard code value (3) to ARRAY_SIZE(tas2781_snd_controls)/2.
> >  - New patch apply for change position of component_del().
> >  - Change label from out, out1 to config_err and block_err.
> >  - Remove unnecessary parentheses in tas2781_spi_fwlib.c.
> >  - Remove tasdevice_spi_prmg_calibdata_load().
> > v8:
> >  - Move *-y position in sound/pci/hda/Makefile.
> >  - Change + to | for bit operation in macro define.
> >  - Change TASDEVICE_Checksum to TASDEVICE_CHECKSUM.
> > v7:
> >  - Add new project Gemtree (0x103c8daa) support for tas2781 spi driver.
> > v6:
> >  - Remove client in tasdevice_priv struct as it was not used.
> >  - Change format for tasdevice_spi_dev_write() in tas2781_hda_spi.c.
> >  - Change update bits function to read & write mode, as tas2781 use last bit
> >    to mask read & write, it cause regmap_update_bits work not as our expected.
> >  - Add element in tas2781_snd_controls, tas2781_prof_ctrl,
> >    tas2781_dsp_conf_ctrl, to support second device.
> >    Previous version add sound card for first index only.
> >  - Change calibration registers address declaire to TASDEVICE_REG() mode.
> >  - Add snd_ctl_new1() for second device.
> >  - Change format for tas2781_hda_unbind() to fit 79 chars in one line.
> >  - Remove client for spi as it was not used.
> >  - Remove unused variables.
> >  - Remove cur_prog clean in runtime_suspend().
> >  - Remove unused variables.
> >  - Add tasdevice_spi_tuning_switch() in runtime_resume.
> >  - Remove cur_prog clean in system_resume().
> >  - Add tuning switch if playback started in system_resume().
> >  - Change TASDEVICE_PAGE_REG to TASDEVICE_REG_ID in tas2781_spi_fwlib.c.
> >  - Remove calibration binary load functions as data will be loaded from EFI.
> > v5:
> >  - Combined all modification into one patch for pass the compile.
> >  - Remove old hardware id "TIAS2781" as no production on market.
> >  - Change max page size to 256 in tas2781-spi.h.
> >  - Change book reg from 127 to GENMASK(7, 1), as one bit shift is needed.
> >  - Change register address define as one bit shift needed for offset.
> >  - Change block check sum comments to Firmware block from I2C.
> >  - Change define of (page + reg) to TASDEVICE_PAGE_REG from TASDEVICE_PGRG.
> >  - Change to lower case in defined value.
> >  - Add registers default value table in tas2781_hda_spi.c
> >  - Change rang_max to 256 * 256.
> >  - Add zero_flag_mask in regmap_config.
> >  - Change max_register to 256 * 256.
> >  - Add registers default table into structure regmap_config.
> >  - Change parameter from book number to whole register address.
> >  - Remove page 0 switch as SPI driver will do it.
> >  - Add bit(0) for read function as tas2781 will check last bit of address,
> >    to determine operation mode is read (1) or write (0).
> >  - Change switch case to if check in tas2781_hda_playback_hook(),
> >    as it may cause compile problem in clang-19 building.
> >  - Change variable declaration position.
> >  - Change order in if check.
> >  - Remove old hardware id ("TIAS2781") support.
> >  - Remove debug message in runtime suspend and resume.
> >  - Remove regmap.h include in tas2781_spi_fwlib.c.
> >  - Remove MODULE_ in fwlib as this file will work with tas2781_hda_spi.c only.
> > v4:
> >  - Add old hardware id "TIAS2781" for compatible with old production
> >  - Add 2 devices in struct smi_node tas2781_hda, to compatible with 4 AMPs
> > v4:
> >  - Add old hardware id "TIAS2781" for compatible with old production
> >  - Add 2 devices in struct smi_node tas2781_hda, to compatible with 4 AMPs
> >  - Move include of sound/tas2781-dsp.h to c source file tas2781_hda_spi.c,
> >    tas2781_spi_fwlib.c, as it's not needed in header file tas2781-spi.h
> >  - Use page and book number define in other micro define
> >  - Change 4000000 to (4 * HZ_PER_MHZ)
> >  - Add define for calibration variable name and size in UEFI.
> >  - Remove structure tasdevice & tasdevice_irqinfo, and move variables in to
> >    structure tasdevice_priv
> >  - Remove some unused variables in sttructure tasdevice_priv
> >  - Remove function declare of tascodec_init(), use tascodec_spi_init()
> >  - Remove function declare of tasdevice_remove()
> >  - Add array_size.h included in tas2781_hda_spi.c
> >  - Add cleanup.h included for change mutex to guard
> >  - Add units.h included
> >  - Include tas2781-dsp.h
> >  - Remove unused variables in tas2781_hda structure
> >  - Change 0xff to GENMASK(7, 0)
> >  - Change 128 to define of max page size
> >  - Change code as all variables was moved to tasdevice_priv structure
> >  - Change comments for error in book write, or page write
> >  - Remove initial of ret, and return 0 directly
> >  - Change comments for wrong typo, add space in front and end
> >  - Add check for bulk read, max size should be a page size
> >  - Change usleep_rang() to fsleep()
> >  - Change mutex_lock to guard(mutex), and remove mutex_unlock()
> >  - Change tasdevice_spi_init() to void from int as no value return required
> >  - Change second parameter to sizeof
> >  - Remove tasdevice_clamp(), use clamp()
> >  - Add compatible with old hardware id "TIAS2781"
> >  - Remove cs_gpio and spi device in tas2781_read_acpi() as use default CS
> >  - Change dev-index check, return -EINVAL if it's <= 0
> >  - Change 0xFF to U8_MAX
> >  - Remove GPIO get for chip-select, use default from SPI device
> >  - Perform RESET in first AMP only as all AMPs share same RESET pin
> >  - return 0 directly in some simple routine to avoid variable initial
> >  - Change comments for function which was used by system
> >  - Change "ON" "OFF" to function str_on_off(...)
> >  - Change format of GUID
> >  - Add temp buffer for first efi.get_variable()
> >  - Free data if it was allocated
> >  - Change format of debug message of calibration date time print
> >  - Remove total_sz = 0, as it's not needed
> >  - Move save_calibration to after tuning_switch to avoid calibration data
> >    overwrite
> >  - Remove dev from structure tasdevice_hda, use dev in tasdevice_priv
> >  - Remove 0 from { "tas2781-hda", 0}, & {"TXNW2781", 0},
> >  - Add old hardware id "TIAS2781" for compatible with old production
> >  - Add 2 devices in struct smi_node tas2781_hda, to compatible with 4 AMPs
> > v3:
> >  - Move HID up to above /* Non-conforming _HID ... */ in scan.c,
> >    for avoid misunderstanding.
> >  - Move HID up to above /* Non-conforming _HID ... */ in
> >    serial-multi-instantiate.c, for avoid misunderstanding.
> >  - Change objs to y for snd-hda-scodec-tas2781-spi- in Makefile.
> >  - Change format for some define in tas2781-spi.h.
> >  - Add define for TASDEVICE_MAX_BOOK_NUM, TASDEVICE_MAX_PAGE.
> >  - Move declare of "enum calib_data {" to header file from source file.
> >  - Remove "enum device_catlog_id {" as only one platform was supported now.
> >  - Remove "struct calidata", as we will save pure calibration data only.
> >  - Remove "struct calidata", "enum device_catlog_id" in tasdevice_priv.
> >  - Add calibration_data in tasdevice_priv to save pure calibration data.
> >  - Remove declare of tasdevice_save_calibration() and
> >    tasdevice_apply_calibration(), as it will be used within same c file.
> >  - Add below header files included in tas2781_hda_spi.c:
> >    bits.h, mutex.h, property.h, time.h, types.h.
> >  - Move two micro define to header file tas2781-spi.h.
> >  - Change format of some micro define.
> >  - Change format of some structure.
> >  - Remove irq in tas2781_hda, as have it already in tasdevice_priv.
> >  - Remove some local functions declare as not necessarily.
> >  - Return error if regmap_write() failed.
> >  - Change fixed value 2 to sizeof(data).
> >  - Remove all of EXPORT_SYMBOL_GPL,
> >    as all of function was called within same module.
> >  - Remove empty line after last return in some functions.
> >  - Remove some variable initialyzation.
> >  - Remove variable sub, store acpi_subsystem_id directly.
> >  - Remove wrong comments for device index, it's must, can't be NULL.
> >  - Remove some local variables, use elements in structure directly.
> >  - Append commas in last element of an array.
> >  - Change calibration data process, didn't save all of calibration data in EFI,
> >    get in local, and save pure calibration data in tasdevice_priv.
> >  - Call tasdevice_save_calibration() from function pointer in tasdevice_priv;
> >  - Remove subid as one platform was supported only, needn't check.
> >  - Add initialyzation for local variable.
> >  - Move regmap initialyzation to before acpi read.
> >  - Call tasdevice_apply_calibration() from function pointer in tasdevice_priv;
> >  - Remove MODULE_IMPORT_NS(SND_SOC_TAS2781_FMWLIB), as all functions was
> >    performed within same module.
> >  - Update format and variables declare order.
> >  - Change format of multi conditions for if.
> >  - Remove casting which is not needed.
> >  - Change variables type to avoid casting.
> >  - Remove Unneeded parentheses.
> >  - Change if check to avoid goto.
> >  - Add {} for keep same style.
> >  - Remove some local variables, use elements in structure directly.
> > v2:
> >  - Change depends on SPI to SPI_MASTER in sound/pci/hda/Kconfig
> >  - Add select SND_HDA_SCODEC_COMPONENT in sound/pci/hda/Kconfig
> >  - Change comp_generic_fixup() 5th parameter from "-%s:00" to
> >    "-%s:00-tas2781-hda.%d" in sound/pci/hda/patch_realtek.c
> >  - Change chain_id from ALC285_FIXUP_THINKPAD_HEADSET_JACK to
> >    ALC285_FIXUP_HP_GPIO_LED in sound/pci/hda/patch_realtek.c
> >  - Remove project name "Gemtree"
> >  - Update information in file header of tas2781-spi.h.
> >  - Remove useless micro define.
> >  - Change TASDEVICE_I2CChecksum to TASDEVICE_Checksum
> >  - Remove enum control_bus as current code support SPI only.
> >  - Remove device define as current code support TAS2781 only.
> >  - Remove spi_device **spi_devs in structure tasdevice_priv.
> >  - Remove cal_binaryname in structure tasdevice_priv.
> >  - Remove ndev in structure tasdevice_priv.
> >  - Change isacpi and  isspi, replace by control_bus(I2C or SPI).
> >  - Remove void tasdevice_spi_dsp_remove(void *context).
> >  - Add acpi_device and irq in structure tas2781_hda in tas2781_hda_spi.c.
> >  - Remove parameter chn in all of registers access functions.
> >  - Add tascodec_spi_init().
> >  - Add chip select gpio set for SPI device.
> >  - Change tasdevice_tuning_switch() to tasdevice_spi_tuning_switch().
> >  - Change device offset from tas_priv->ndev to tas_priv->index.
> >  - Change tasdevice_dsp_remove() to tasdevice_spi_dsp_remove().
> >  - tasdevice_prmg_load() to tasdevice_spi_prmg_load().
> >  - Change tasdevice_config_info_remove() to
> >    tasdevice_spi_config_info_remove().
> >  - Add one dummy byte shift when read from page 2~127, or not book 0.
> >  - Change tasdevice_spi_change_chn_book() to tasdevice_spi_switch_book()
> >  - Perform put_device(physdev) before error return.
> >  - Change calibration data id to 2781 from 2783 in EFI
> >  - Change calibration data structure name in comments.
> >  - Remove file name in tas2781_spi_fwlib.c.
> >  - Remove #include <linux/i2c.h> as it not needed in SPI mode.
> >  - Change TAB to speace in micro define in tas2781_spi_fwlib.c.
> >  - Change to up-case for DSP.
> >  - Change all of multi-line comments format, empty first line.
> >  - Change all of sizeof(struct xx) to sizeof(*xx).
> >  - Remove Explicit casting for variables compare to avoid possible fault.
> >  - Return directly without goto.
> >  - Change 1 << xx to BIT(xx).
> >  - Remove deviceNumber[] as current SPI device will support one device only.
> >  - Add memory free before return error.
> >  - Change "buf[offset]; offset += 1" to buf[offset++].
> >  - Remove some debug information print.
> >  - Change firmware binary to single device mode.
> >  - Change all bexx_to_cpup() to get_unaligned_bexx().
> >  - Remove ndev process as current SPI device support single device only.
> >  - Remove chn and chnend for single device support only.
> >  - Change all of registers read/write function, remove parameter chn.
> >  - Create new function for single write, burst write, delay, field write
> >    in tasdevice_process_block().
> > ---
> >  drivers/acpi/scan.c                           |    1 +
> >  .../platform/x86/serial-multi-instantiate.c   |   12 +
> >  sound/pci/hda/Kconfig                         |   14 +
> >  sound/pci/hda/Makefile                        |    2 +
> >  sound/pci/hda/patch_realtek.c                 |   14 +
> >  sound/pci/hda/tas2781-spi.h                   |  158 ++
> >  sound/pci/hda/tas2781_hda_spi.c               | 1271 +++++++++++
> >  sound/pci/hda/tas2781_spi_fwlib.c             | 2008 +++++++++++++++++
> >  8 files changed, 3480 insertions(+)
> 
> So this series reached already v12, and we'd really like to take in
> some form.  Although the code is still much more complex than I
> wished, it's more or less readable and understandable in some level,
> so I'm fine about the sound/* part.
> 
> OTOH, this contains also the changes for drivers/acpi/scan.c and
> drivers/platform/x86/serial-multi-instantiate.c, and those need Acks
> from the corresponding people, but it missed Cc to them (and MLs).
> Now I put them to Cc.
> 
> Rafael, Hans, Ilpo, Andy, anyone else - could you guys check it?

FYI, I merged the patch now for 6.14.
Let me know if you see any issues.


thanks,

Takashi

